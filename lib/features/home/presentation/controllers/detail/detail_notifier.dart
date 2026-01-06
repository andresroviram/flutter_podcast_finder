import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/core/error/failures.dart';
import 'package:podcast_finder/features/home/domain/entities/entities.dart';
import 'package:podcast_finder/features/home/domain/usecases/podcast_usecases.dart';
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

    final podcast = await _podcastUseCase.getPodcastById(id);

    podcast.fold(
      (Failure failure) {
        state = DetailError(failure.message);
      },
      (PodcastDetailEntity podcastDetail) {
        state = DetailSuccess(podcastDetail);
      },
    );
  }

  void reset() {
    state = const DetailInitial();
  }
}

final detailNotifierProvider =
    NotifierProvider.family<DetailNotifier, DetailState, String>(
      DetailNotifier.new,
    );
