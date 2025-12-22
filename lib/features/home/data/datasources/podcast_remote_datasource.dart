import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/network_exceptions.dart';
import '../models/podcast_model.dart';
import '../models/podcast_detail_model.dart';

final podcastRemoteDataSourceProvider = Provider<PodcastRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return PodcastRemoteDataSource(dio);
});

class PodcastRemoteDataSource {
  final Dio _dio;

  PodcastRemoteDataSource(this._dio);

  Future<List<PodcastModel>> searchPodcasts(String query) async {
    try {
      Response response = await _dio.get(
        '/search',
        queryParameters: {'q': query},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final results = data['results'] as List;
        return results
            .map((json) => PodcastModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(response.statusCode ?? 500);
      }
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<PodcastDetailModel> getPodcastById(String id) async {
    try {
      final response = await _dio.get('/podcasts/$id');

      if (response.statusCode == 200) {
        return PodcastDetailModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw ServerException(response.statusCode ?? 500);
      }
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
