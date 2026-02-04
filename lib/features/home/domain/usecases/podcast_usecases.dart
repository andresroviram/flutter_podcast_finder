import 'package:podcast_finder/core/result.dart';

import '../entities/entities.dart';
import '../repositories/podcast_repository.dart';

class PodcastUseCase {
  PodcastUseCase(this.podcastRepository);

  final IPodcastRepository podcastRepository;

  Future<Result<List<PodcastEntity>>> searchPodcasts(String query) async {
    return podcastRepository.searchPodcasts(query);
  }

  Future<Result<PodcastDetailEntity>> getPodcastById(String id) async {
    return podcastRepository.getPodcastById(id);
  }
}
