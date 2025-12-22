import 'package:dio/dio.dart';
import '../../../../core/network/dio_response_extensions.dart';
import '../models/podcast_model.dart';
import '../models/podcast_detail_model.dart';

abstract class PodcastDataSource {
  Future<List<PodcastModel>> searchPodcasts(String query);
  Future<PodcastDetailModel> getPodcastById(String id);
}

class PodcastDataSourceImpl implements PodcastDataSource {
  final Dio _dio;

  PodcastDataSourceImpl(this._dio);

  @override
  Future<List<PodcastModel>> searchPodcasts(String query) async {
    try {
      final response = await _dio.get('/search', queryParameters: {'q': query});

      return response.withListConverterFromKey(
        'results',
        callback: PodcastModel.fromJson,
      );
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<PodcastDetailModel> getPodcastById(String id) async {
    try {
      final response = await _dio.get('/podcasts/$id');

      return response.withConverter(callback: PodcastDetailModel.fromJson);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
