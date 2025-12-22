import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:podcast_finder/features/home/domain/entities/entities.dart';
import 'package:podcast_finder/features/home/presentation/controllers/search/search_notifier.dart';
import 'package:podcast_finder/features/home/presentation/controllers/search/search_state.dart';
import 'package:podcast_finder/features/home/domain/usecases/podcast_usecases.dart';
import 'package:podcast_finder/features/home/presentation/providers/podcast/podcast_provider.dart';
import 'package:podcast_finder/core/network/network_exceptions.dart';

class MockPodcastUseCase extends Mock implements PodcastUseCase {}

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
      expect(state, isA<SearchInitial>());
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
        ).thenAnswer((_) async => mockPodcasts);

        final notifier = container.read(searchNotifierProvider.notifier);

        // Act
        await notifier.search('flutter');

        // Assert
        final state = container.read(searchNotifierProvider);
        expect(state, isA<SearchSuccess>());
        if (state is SearchSuccess) {
          expect(state.podcasts, mockPodcasts);
          expect(state.query, 'flutter');
        }
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
      ).thenAnswer((_) async => mockPodcasts);

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      await notifier.search('');

      // Assert
      final state = container.read(searchNotifierProvider);
      expect(state, isA<SearchSuccess>());
      if (state is SearchSuccess) {
        expect(state.podcasts, mockPodcasts);
      }
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
      ).thenAnswer((_) async => mockPodcasts);

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      await notifier.search('   ');

      // Assert
      final state = container.read(searchNotifierProvider);
      expect(state, isA<SearchSuccess>());
    });

    test('search returns SearchEmpty when no podcasts found', () async {
      // Arrange
      when(
        () => mockPodcastUseCase.searchPodcasts('nonexistent'),
      ).thenAnswer((_) async => []);

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      await notifier.search('nonexistent');

      // Assert
      final state = container.read(searchNotifierProvider);
      expect(state, isA<SearchEmpty>());
      if (state is SearchEmpty) {
        expect(state.query, 'nonexistent');
      }
    });

    test('search returns SearchError when NetworkException occurs', () async {
      // Arrange
      when(
        () => mockPodcastUseCase.searchPodcasts('error'),
      ).thenThrow(const ServerException(500));

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      await notifier.search('error');

      // Assert
      final state = container.read(searchNotifierProvider);
      expect(state, isA<SearchError>());
      if (state is SearchError) {
        expect(state.message, 'Server error (500). Please try again later.');
      }
    });

    test('search returns SearchError when generic exception occurs', () async {
      // Arrange
      when(
        () => mockPodcastUseCase.searchPodcasts('error'),
      ).thenThrow(Exception('Generic error'));

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      await notifier.search('error');

      // Assert
      final state = container.read(searchNotifierProvider);
      expect(state, isA<SearchError>());
      if (state is SearchError) {
        expect(
          state.message,
          'An unexpected error occurred. Please try again.',
        );
      }
    });

    test('search sets loading state during execution', () async {
      // Arrange
      when(() => mockPodcastUseCase.searchPodcasts('test')).thenAnswer((
        _,
      ) async {
        // Simula delay
        await Future.delayed(const Duration(milliseconds: 100));
        return [];
      });

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      final future = notifier.search('test');

      // Assert loading state
      await Future.delayed(const Duration(milliseconds: 50));
      final loadingState = container.read(searchNotifierProvider);
      expect(loadingState, isA<SearchLoading>());

      // Wait for completion
      await future;
      final finalState = container.read(searchNotifierProvider);
      expect(finalState, isA<SearchEmpty>());
    });

    test('reset returns state to initial', () {
      // Arrange
      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      notifier.reset();

      // Assert
      final state = container.read(searchNotifierProvider);
      expect(state, isA<SearchInitial>());
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
