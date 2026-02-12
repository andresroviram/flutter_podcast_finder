import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/core/error/failures.dart';
import 'package:podcast_finder/core/result.dart';
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
    return const DetailState.initial();
  }

  PodcastUseCase get _podcastUseCase => ref.read(podcastUseCaseProvider);

  Future<void> loadPodcastDetails(String id) async {
    state = const DetailState.loading();

    final result = await _podcastUseCase.getPodcastById(id);

    result.fold(
      onSuccess: (PodcastDetailEntity podcastDetail) {
        state = DetailState.success(podcastDetail);
      },
      onFailure: (Failures error) {
        state = DetailState.error(error.message);
      },
    );
  }

  void reset() {
    state = const DetailState.initial();
  }
}

final detailNotifierProvider =
    NotifierProvider.family<DetailNotifier, DetailState, String>(
      DetailNotifier.new,
    );
