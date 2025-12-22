import '../entities/entities.dart';
import '../repositories/podcast_repository.dart';

class PodcastUseCase {
  PodcastUseCase(this.podcastRepository);

  final PodcastRepository podcastRepository;

  Future<List<PodcastEntity>> searchPodcasts(String query) async {
    return podcastRepository.searchPodcasts(query);
  }

  Future<PodcastDetailEntity> getPodcastById(String id) async {
    return podcastRepository.getPodcastById(id);
  }
}
