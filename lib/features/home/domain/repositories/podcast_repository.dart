import '../entities/entities.dart';

abstract class PodcastRepository {
  Future<List<PodcastEntity>> searchPodcasts(String query);
  Future<PodcastDetailEntity> getPodcastById(String id);
}
