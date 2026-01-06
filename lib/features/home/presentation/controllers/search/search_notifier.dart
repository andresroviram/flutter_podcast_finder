import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:podcast_finder/core/error/failures.dart';
import 'package:podcast_finder/features/home/domain/usecases/podcast_usecases.dart';
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

    final allPodcasts = await _podcastUseCase.searchPodcasts(query);

    allPodcasts.fold(
      (Failure error) {
        state = SearchError(error.message);
      },
      (List<PodcastEntity> allPodcasts) {
        final filteredPodcasts = query.trim().isEmpty
            ? allPodcasts
            : filterPodcastsByTitle(allPodcasts, query);

        if (filteredPodcasts.isEmpty) {
          state = SearchEmpty(query);
        } else {
          final limitedPodcasts = filteredPodcasts.take(10).toList();
          state = SearchSuccess(limitedPodcasts, query);
        }
      },
    );
  }

  void reset() {
    state = const SearchInitial();
  }
}

final searchNotifierProvider = NotifierProvider<SearchNotifier, SearchState>(
  SearchNotifier.new,
);
