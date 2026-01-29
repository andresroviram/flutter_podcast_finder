import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/entities.dart';
import '../controllers/detail/detail_notifier.dart';
import '../controllers/detail/detail_state.dart';
import '../widgets/episode_list_tile.dart';

class PodcastDetailScreen extends ConsumerWidget {
  final String podcastId;

  const PodcastDetailScreen({super.key, required this.podcastId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(detailNotifierProvider(podcastId));

    return Scaffold(body: _buildBody(context, ref, detailState));
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, DetailState state) {
    return state.when(
      initial: () => _buildLoadingState(context),
      loading: () => _buildLoadingState(context),
      success: (podcast) => _buildSuccessState(context, podcast),
      error: (message) => _buildErrorState(context, ref, message),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: AppColors.surfaceVariant,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
          leading: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.black70,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildShimmerBox(height: 32, width: double.infinity),
                const SizedBox(height: 8),
                _buildShimmerBox(height: 20, width: 150),
                const SizedBox(height: 16),
                _buildShimmerBox(height: 60, width: double.infinity),
                const SizedBox(height: 24),
                _buildShimmerBox(height: 24, width: 200),
                const SizedBox(height: 16),
                ...List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildShimmerBox(height: 80, width: double.infinity),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerBox({required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, PodcastDetailEntity podcast) {
    final episodes = podcast.episodes.take(5).toList();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.black70,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
              padding: EdgeInsets.zero,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              podcast.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    color: AppColors.black45,
                  ),
                ],
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: podcast.imageUrl ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.surfaceVariant,
                    child: const Icon(
                      Icons.podcasts,
                      size: 80,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.surfaceVariant,
                    child: const Icon(
                      Icons.podcasts,
                      size: 80,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.transparent, AppColors.black70],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  podcast.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF212529),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  podcast.publisher,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6C757D),
                  ),
                ),
              ),

              if (podcast.description != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    podcast.description!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF212529),
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              if (episodes.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(
                    'Recent Episodes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212529),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...episodes.map((episode) => EpisodeListTile(episode: episode)),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String message) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(title: Text('Podcast Details'), pinned: true),
        SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.errorLight,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Failed to load podcast details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      ref
                          .read(detailNotifierProvider(podcastId).notifier)
                          .loadPodcastDetails(podcastId);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
