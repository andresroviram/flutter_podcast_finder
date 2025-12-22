import 'package:dio/dio.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repositories/podcast_repository.dart';
import '../datasources/podcast_datasource.dart';
import '../models/podcast_model.dart';
import '../models/podcast_detail_model.dart';

final class PodcastRepositoryImpl implements PodcastRepository {
  final PodcastDataSource _podcastDataSource;

  PodcastRepositoryImpl(this._podcastDataSource);

  @override
  Future<List<PodcastEntity>> searchPodcasts(String query) async {
    try {
      List<PodcastModel> models = await _podcastDataSource.searchPodcasts(
        query,
      );
      return models.map((e) => e.toEntity()).toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  @override
  Future<PodcastDetailEntity> getPodcastById(String id) async {
    try {
      PodcastDetailModel model = await _podcastDataSource.getPodcastById(id);
      return model.toEntity();
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
