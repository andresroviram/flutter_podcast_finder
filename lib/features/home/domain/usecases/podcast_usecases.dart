import 'package:fpdart/fpdart.dart';
import 'package:podcast_finder/core/error/failures.dart';

import '../entities/entities.dart';
import '../repositories/podcast_repository.dart';

class PodcastUseCase {
  PodcastUseCase(this.podcastRepository);

  final PodcastRepository podcastRepository;

  Future<Either<Failure, List<PodcastEntity>>> searchPodcasts(
    String query,
  ) async {
    return podcastRepository.searchPodcasts(query);
  }

  Future<Either<Failure, PodcastDetailEntity>> getPodcastById(String id) async {
    return podcastRepository.getPodcastById(id);
  }
}
