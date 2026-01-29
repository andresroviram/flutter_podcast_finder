import 'package:podcast_finder/core/error/failures.dart';
import 'package:podcast_finder/core/result.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repositories/podcast_repository.dart';
import '../datasources/podcast_datasource.dart';
import '../models/podcast_model.dart';
import '../models/podcast_detail_model.dart';

final class PodcastRepositoryImpl implements PodcastRepository {
  final PodcastDataSource _podcastDataSource;

  PodcastRepositoryImpl(this._podcastDataSource);

  @override
  Future<Result<List<PodcastEntity>>> searchPodcasts(String query) async {
    try {
      List<PodcastModel> models = await _podcastDataSource.searchPodcasts(
        query,
      );
      return Success(models.map((e) => e.toEntity()).toList());
    } on Failures catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<PodcastDetailEntity>> getPodcastById(String id) async {
    try {
      PodcastDetailModel model = await _podcastDataSource.getPodcastById(id);
      return Success(model.toEntity());
    } on Failures catch (e) {
      return Failure(e);
    }
  }
}
