import 'package:fpdart/fpdart.dart';
import 'package:podcast_finder/core/error/failures.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repositories/podcast_repository.dart';
import '../datasources/podcast_datasource.dart';
import '../models/podcast_model.dart';
import '../models/podcast_detail_model.dart';

final class PodcastRepositoryImpl implements PodcastRepository {
  final PodcastDataSource _podcastDataSource;

  PodcastRepositoryImpl(this._podcastDataSource);

  @override
  Future<Either<Failure, List<PodcastEntity>>> searchPodcasts(
    String query,
  ) async {
    try {
      List<PodcastModel> models = await _podcastDataSource.searchPodcasts(
        query,
      );
      return Right(models.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, PodcastDetailEntity>> getPodcastById(String id) async {
    try {
      PodcastDetailModel model = await _podcastDataSource.getPodcastById(id);
      return Right(model.toEntity());
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
