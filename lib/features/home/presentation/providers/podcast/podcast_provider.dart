import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/features/home/data/repositories/podcast_repository.dart';
import 'package:podcast_finder/features/home/data/datasources/podcast_datasource.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../domain/repositories/podcast_repository.dart';
import '../../../domain/usecases/podcast_usecases.dart';

final podcastDataSourceProvider = Provider<IPodcastDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return PodcastDataSourceImpl(apiClient);
});

final podcastRepositoryProvider = Provider<IPodcastRepository>((ref) {
  final podcastDataSource = ref.watch(podcastDataSourceProvider);
  return PodcastRepositoryImpl(podcastDataSource);
});

final podcastUseCaseProvider = Provider<PodcastUseCase>((ref) {
  final repository = ref.watch(podcastRepositoryProvider);
  return PodcastUseCase(repository);
});
