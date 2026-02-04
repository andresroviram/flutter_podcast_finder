import 'package:podcast_finder/core/error/failures.dart';
import 'package:podcast_finder/core/network/api_client.dart';
import '../../../../core/network/dio_response_extensions.dart';
import '../models/podcast_model.dart';
import '../models/podcast_detail_model.dart';

abstract class IPodcastDataSource {
  Future<List<PodcastModel>> searchPodcasts(String query);
  Future<PodcastDetailModel> getPodcastById(String id);
}

class PodcastDataSourceImpl implements IPodcastDataSource {
  final ApiClient _apiClient;

  PodcastDataSourceImpl(this._apiClient);

  @override
  Future<List<PodcastModel>> searchPodcasts(String query) async {
    try {
      final response = await _apiClient.get(
        '/search',
        queryParameters: {'q': query},
      );

      return response.withListConverterFromKey<PodcastModel>(
        'results',
        callback: PodcastModel.fromJson,
      );
    } on Failures catch (_) {
      rethrow;
    }
  }

  @override
  Future<PodcastDetailModel> getPodcastById(String id) async {
    try {
      return (await _apiClient.get(
        '/podcasts/$id',
      )).withConverter<PodcastDetailModel>(
        callback: PodcastDetailModel.fromJson,
      );
    } on Failures catch (_) {
      rethrow;
    }
  }
}
