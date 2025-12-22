import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/domain/usecases/podcast_usecases.dart';
import '../../../../../core/network/network_exceptions.dart';
import '../../providers/podcast/podcast_provider.dart';
import 'detail_state.dart';

class DetailNotifier extends Notifier<DetailState> {
  DetailNotifier(this._podcastId);

  final String _podcastId;

  @override
  DetailState build() {
    loadPodcastDetails(_podcastId);
    return const DetailInitial();
  }

  PodcastUseCase get _podcastUseCase => ref.read(podcastUseCaseProvider);

  Future<void> loadPodcastDetails(String id) async {
    state = const DetailLoading();

    try {
      final podcast = await _podcastUseCase.getPodcastById(id);
      state = DetailSuccess(podcast);
    } on NetworkException catch (e) {
      state = DetailError(e.message);
    } catch (e) {
      state = const DetailError(
        'An unexpected error occurred. Please try again.',
      );
    }
  }

  void reset() {
    state = const DetailInitial();
  }
}

final detailNotifierProvider =
    NotifierProvider.family<DetailNotifier, DetailState, String>(
      DetailNotifier.new,
    );
