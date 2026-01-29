import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:podcast_finder/core/result.dart' as result;
import 'package:podcast_finder/core/error/failures.dart';
import 'package:podcast_finder/features/home/domain/entities/entities.dart';
import 'package:podcast_finder/features/home/presentation/controllers/search/search_notifier.dart';
import 'package:podcast_finder/features/home/presentation/controllers/search/search_state.dart';
import 'package:podcast_finder/features/home/domain/usecases/podcast_usecases.dart';
import 'package:podcast_finder/features/home/presentation/providers/podcast/podcast_provider.dart';
import 'package:podcast_finder/core/network/api_client.dart';

class MockPodcastUseCase extends Mock implements PodcastUseCase {}

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('SearchNotifier', () {
    late ProviderContainer container;
    late MockPodcastUseCase mockPodcastUseCase;

    setUp(() {
      mockPodcastUseCase = MockPodcastUseCase();

      container = ProviderContainer(
        overrides: [
          podcastUseCaseProvider.overrideWithValue(mockPodcastUseCase),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is SearchInitial', () {
      // Act
      final state = container.read(searchNotifierProvider);

      // Assert
      expect(state, const SearchState.initial());
    });

    test(
      'search with query returns SearchSuccess when podcasts found',
      () async {
        // Arrange
        const mockPodcasts = [
          PodcastEntity(
            id: 'test-1',
            title: 'Flutter Dev Podcast',
            publisher: 'Test Publisher',
          ),
          PodcastEntity(
            id: 'test-2',
            title: 'Flutter Weekly',
            publisher: 'Another Publisher',
          ),
        ];

        when(
          () => mockPodcastUseCase.searchPodcasts('flutter'),
        ).thenAnswer((_) async => const result.Success(mockPodcasts));

        final notifier = container.read(searchNotifierProvider.notifier);

        // Act
        await notifier.search('flutter');

        // Assert
        final state = container.read(searchNotifierProvider);
        state.maybeWhen(
          success: (podcasts, query) {
            expect(podcasts, mockPodcasts);
            expect(query, 'flutter');
          },
          orElse: () => fail('State is not success'),
        );
      },
    );

    test('search with empty query loads all podcasts', () async {
      // Arrange
      const mockPodcasts = [
        PodcastEntity(
          id: 'test-1',
          title: 'Test Podcast',
          publisher: 'Test Publisher',
        ),
      ];

      when(
        () => mockPodcastUseCase.searchPodcasts(''),
      ).thenAnswer((_) async => const result.Success(mockPodcasts));

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      await notifier.search('');

      // Assert
      final state = container.read(searchNotifierProvider);
      state.maybeWhen(
        success: (podcasts, _) => expect(podcasts, mockPodcasts),
        orElse: () => fail('State is not success'),
      );
    });

    test('search with whitespace query loads all podcasts', () async {
      // Arrange
      const mockPodcasts = [
        PodcastEntity(
          id: 'test-1',
          title: 'Test Podcast',
          publisher: 'Test Publisher',
        ),
      ];

      when(
        () => mockPodcastUseCase.searchPodcasts('   '),
      ).thenAnswer((_) async => const result.Success(mockPodcasts));

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      await notifier.search('   ');

      // Assert
      final state = container.read(searchNotifierProvider);
      state.maybeWhen(
        success: (_, _) {},
        orElse: () => fail('State is not success'),
      );
    });

    test('search returns SearchEmpty when no podcasts found', () async {
      // Arrange
      when(
        () => mockPodcastUseCase.searchPodcasts('nonexistent'),
      ).thenAnswer((_) async => const result.Success(<PodcastEntity>[]));

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      await notifier.search('nonexistent');

      // Assert
      final state = container.read(searchNotifierProvider);
      state.maybeWhen(
        empty: (query) => expect(query, 'nonexistent'),
        orElse: () => fail('State is not empty'),
      );
    });

    test('search returns SearchError when NetworkException occurs', () async {
      // Arrange
      when(() => mockPodcastUseCase.searchPodcasts('error')).thenAnswer(
        (_) async =>
            const result.Failure(ServerFailure(message: 'Server error')),
      );

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      await notifier.search('error');

      // Assert
      final state = container.read(searchNotifierProvider);
      state.maybeWhen(
        error: (message) => expect(message, 'Server error'),
        orElse: () => fail('State is not error'),
      );
    });

    test('search returns SearchError when generic exception occurs', () async {
      // Arrange
      when(() => mockPodcastUseCase.searchPodcasts('error')).thenAnswer(
        (_) async =>
            const result.Failure(ServerFailure(message: 'Generic error')),
      );

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      await notifier.search('error');

      // Assert
      final state = container.read(searchNotifierProvider);
      state.maybeWhen(
        error: (message) => expect(message, 'Generic error'),
        orElse: () => fail('State is not error'),
      );
    });

    test('search sets loading state during execution', () async {
      // Arrange
      when(() => mockPodcastUseCase.searchPodcasts('test')).thenAnswer((
        _,
      ) async {
        // Simula delay
        await Future.delayed(const Duration(milliseconds: 100));
        return const result.Success(<PodcastEntity>[]);
      });

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      final future = notifier.search('test');

      // Assert loading state
      await Future.delayed(const Duration(milliseconds: 50));
      final loadingState = container.read(searchNotifierProvider);
      expect(loadingState, const SearchState.loading());

      // Wait for completion
      await future;
      final finalState = container.read(searchNotifierProvider);
      finalState.maybeWhen(
        empty: (_) {},
        orElse: () => fail('State is not empty'),
      );
    });

    test('reset returns state to initial', () {
      // Arrange
      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      notifier.reset();

      // Assert
      final state = container.read(searchNotifierProvider);
      expect(state, const SearchState.initial());
    });

    test('filterPodcastsByTitle filters podcasts correctly', () {
      // Arrange
      const podcasts = [
        PodcastEntity(
          id: 'test-1',
          title: 'Flutter Dev Podcast',
          publisher: 'Flutter Team',
        ),
        PodcastEntity(
          id: 'test-2',
          title: 'React Native Show',
          publisher: 'React Team',
        ),
        PodcastEntity(
          id: 'test-3',
          title: 'Flutter Weekly',
          publisher: 'Weekly Team',
        ),
      ];

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      final filteredPodcasts = notifier.filterPodcastsByTitle(
        podcasts,
        'flutter',
      );

      // Assert
      expect(filteredPodcasts.length, 2);
      expect(filteredPodcasts[0].title, 'Flutter Dev Podcast');
      expect(filteredPodcasts[1].title, 'Flutter Weekly');
    });
  });

  group('SearchState', () {
    test('SearchInitial is created correctly', () {
      const state = SearchInitial();
      expect(state, isA<SearchState>());
    });

    test('SearchLoading is created correctly', () {
      const state = SearchLoading();
      expect(state, isA<SearchState>());
    });

    test('SearchSuccess holds podcasts and query', () {
      const podcasts = [
        PodcastEntity(
          id: 'test-1',
          title: 'Test Podcast',
          publisher: 'Test Publisher',
        ),
      ];
      const state = SearchSuccess(podcasts, 'test query');

      expect(state.podcasts, podcasts);
      expect(state.query, 'test query');
    });

    test('SearchEmpty holds query', () {
      const state = SearchEmpty('test query');
      expect(state.query, 'test query');
    });

    test('SearchError holds message', () {
      const state = SearchError('Test error message');
      expect(state.message, 'Test error message');
    });
  });
}
