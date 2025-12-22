import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:podcast_finder/features/home/domain/usecases/podcast_usecases.dart';
import '../../../../../core/network/network_exceptions.dart';
import '../../../domain/entities/entities.dart';
import '../../providers/podcast/podcast_provider.dart';
import 'search_state.dart';

class SearchNotifier extends Notifier<SearchState> {
  @override
  SearchState build() {
    return const SearchInitial();
  }

  PodcastUseCase get _podcastUseCase => ref.read(podcastUseCaseProvider);

  @visibleForTesting
  List<PodcastEntity> filterPodcastsByTitle(
    List<PodcastEntity> podcasts,
    String query,
  ) {
    final lowerQuery = query.toLowerCase();
    return podcasts.where((podcast) {
      final title = podcast.title.toLowerCase();
      return title.contains(lowerQuery);
    }).toList();
  }

  Future<void> search(String query) async {
    state = const SearchLoading();

    try {
      final allPodcasts = await _podcastUseCase.searchPodcasts(query);

      final filteredPodcasts = query.trim().isEmpty
          ? allPodcasts
          : filterPodcastsByTitle(allPodcasts, query);

      if (filteredPodcasts.isEmpty) {
        state = SearchEmpty(query);
      } else {
        final limitedPodcasts = filteredPodcasts.take(10).toList();
        state = SearchSuccess(limitedPodcasts, query);
      }
    } on NetworkException catch (e) {
      state = SearchError(e.message);
    } catch (e) {
      state = const SearchError(
        'An unexpected error occurred. Please try again.',
      );
    }
  }

  void reset() {
    state = const SearchInitial();
  }
}

final searchNotifierProvider = NotifierProvider<SearchNotifier, SearchState>(
  SearchNotifier.new,
);
