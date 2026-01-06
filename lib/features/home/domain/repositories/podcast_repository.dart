import 'package:fpdart/fpdart.dart';
import 'package:podcast_finder/core/error/failures.dart';
import '../entities/entities.dart';

abstract class PodcastRepository {
  Future<Either<Failure, List<PodcastEntity>>> searchPodcasts(String query);
  Future<Either<Failure, PodcastDetailEntity>> getPodcastById(String id);
}
