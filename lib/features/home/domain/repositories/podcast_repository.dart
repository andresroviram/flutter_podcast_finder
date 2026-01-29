import 'package:podcast_finder/core/result.dart';
import '../entities/entities.dart';

abstract class PodcastRepository {
  Future<Result<List<PodcastEntity>>> searchPodcasts(String query);
  Future<Result<PodcastDetailEntity>> getPodcastById(String id);
}
