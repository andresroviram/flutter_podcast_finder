import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/debouncer.dart';
import '../../domain/entities/entities.dart';
import '../controllers/search/search_notifier.dart';
import '../controllers/search/search_state.dart';
import '../widgets/podcast_card.dart';
import '../widgets/search_textfield.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(duration: const Duration(milliseconds: 500));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchNotifierProvider.notifier).search('');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debouncer.call(() {
      ref.read(searchNotifierProvider.notifier).search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PodcastFinder'),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          SearchTextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
          Expanded(child: _buildBody(searchState)),
        ],
      ),
    );
  }

  Widget _buildBody(SearchState state) {
    return state.when(
      initial: _buildLoadingState,
      loading: _buildLoadingState,
      success: (podcasts, _) => _buildSuccessState(podcasts),
      empty: _buildEmptyState,
      error: _buildErrorState,
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildSuccessState(List<PodcastEntity> podcasts) {
    return ListView.builder(
      itemCount: podcasts.length,
      itemBuilder: (context, index) {
        final podcast = podcasts[index];
        return PodcastCard(
          podcast: podcast,
          onTap: () {
            context.push('/podcast/${podcast.id}');
          },
        );
      },
    );
  }

  Widget _buildEmptyState(String query) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.podcasts, size: 64, color: AppColors.grey400),
          SizedBox(height: 16),
          Text(
            'No podcasts found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.grey700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(fontSize: 14, color: AppColors.grey600),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
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
              'Oops! Something went wrong',
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
              style: const TextStyle(fontSize: 14, color: AppColors.grey600),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                final query = _searchController.text;
                if (query.isNotEmpty) {
                  ref.read(searchNotifierProvider.notifier).search(query);
                }
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
    );
  }
}
