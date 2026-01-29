import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:podcast_finder/core/result.dart' as result;
import 'package:podcast_finder/core/error/failures.dart';
import 'package:podcast_finder/features/home/domain/entities/entities.dart';
import 'package:podcast_finder/features/home/presentation/controllers/detail/detail_notifier.dart';
import 'package:podcast_finder/features/home/presentation/controllers/detail/detail_state.dart';
import 'package:podcast_finder/features/home/presentation/providers/podcast/podcast_provider.dart';
import 'package:podcast_finder/features/home/domain/usecases/podcast_usecases.dart';

class MockPodcastUseCase extends Mock implements PodcastUseCase {}

void main() {
  group('DetailNotifier', () {
    late ProviderContainer container;
    late MockPodcastUseCase mockPodcastUseCase;

    setUp(() {
      mockPodcastUseCase = MockPodcastUseCase();

      // Setup default mock response para evitar errores en build()
      when(() => mockPodcastUseCase.getPodcastById(any())).thenAnswer(
        (_) async => const result.Success(
          PodcastDetailEntity(
            id: 'test',
            title: 'Test',
            publisher: 'Test',
            episodes: [],
          ),
        ),
      );

      container = ProviderContainer(
        overrides: [
          podcastUseCaseProvider.overrideWithValue(mockPodcastUseCase),
        ],
      );
    });
    tearDown(() {
      container.dispose();
    });

    test('initial state is DetailInitial', () {
      // Use the provider to test initial state
      final state = container.read(detailNotifierProvider('test-podcast-id'));

      // Assert
      expect(state, const DetailState.initial());
    });

    test(
      'loadPodcastDetail returns DetailSuccess when data is loaded',
      () async {
        // Arrange
        const mockPodcast = PodcastDetailEntity(
          id: 'test-1',
          title: 'Test Podcast',
          publisher: 'Test Publisher',
          episodes: [],
        );

        when(
          () => mockPodcastUseCase.getPodcastById('test-1'),
        ).thenAnswer((_) async => const result.Success(mockPodcast));

        final notifier = container.read(
          detailNotifierProvider('test-1').notifier,
        );

        // Act
        await notifier.loadPodcastDetails('test-1');

        // Assert
        final state = container.read(detailNotifierProvider('test-1'));
        state.maybeWhen(
          success: (podcast) {
            expect(podcast.id, 'test-1');
            expect(podcast.title, 'Test Podcast');
          },
          orElse: () => fail('State is not success'),
        );
      },
    );

    test(
      'loadPodcastDetails returns DetailError when NetworkException occurs',
      () async {
        // Arrange
        when(() => mockPodcastUseCase.getPodcastById('error-id')).thenAnswer(
          (_) async =>
              const result.Failure(ServerFailure(message: 'Server error')),
        );

        final notifier = container.read(
          detailNotifierProvider('error-id').notifier,
        );

        // Act
        await notifier.loadPodcastDetails('error-id');

        // Assert
        final state = container.read(detailNotifierProvider('error-id'));
        state.maybeWhen(
          error: (message) => expect(message, 'Server error'),
          orElse: () => fail('State is not error'),
        );
      },
    );

    test(
      'loadPodcastDetails returns DetailError when generic exception occurs',
      () async {
        // Arrange
        when(() => mockPodcastUseCase.getPodcastById('error-id')).thenAnswer(
          (_) async =>
              const result.Failure(ServerFailure(message: 'Generic error')),
        );

        final notifier = container.read(
          detailNotifierProvider('error-id').notifier,
        );

        // Act
        await notifier.loadPodcastDetails('error-id');

        // Assert
        final state = container.read(detailNotifierProvider('error-id'));
        state.maybeWhen(
          error: (message) => expect(message, 'Generic error'),
          orElse: () => fail('State is not error'),
        );
      },
    );

    test('loadPodcastDetails sets loading state during execution', () async {
      // Arrange
      when(() => mockPodcastUseCase.getPodcastById('test-id')).thenAnswer((
        _,
      ) async {
        // Simula delay
        await Future.delayed(const Duration(milliseconds: 100));
        return const result.Success(
          PodcastDetailEntity(
            id: 'test-id',
            title: 'Test Podcast',
            publisher: 'Test Publisher',
            episodes: [],
          ),
        );
      });

      final notifier = container.read(
        detailNotifierProvider('test-id').notifier,
      );

      // Act
      final future = notifier.loadPodcastDetails('test-id');

      // Assert loading state
      await Future.delayed(const Duration(milliseconds: 50));
      final loadingState = container.read(detailNotifierProvider('test-id'));
      expect(loadingState, const DetailState.loading());

      // Wait for completion
      await future;
      final finalState = container.read(detailNotifierProvider('test-id'));
      finalState.maybeWhen(
        success: (_) {},
        orElse: () => fail('State is not success'),
      );
    });

    test('reset returns state to initial', () {
      // Arrange
      final notifier = container.read(
        detailNotifierProvider('test-podcast-id').notifier,
      );

      // Act
      notifier.reset();

      // Assert
      final state = container.read(detailNotifierProvider('test-podcast-id'));
      expect(state, const DetailState.initial());
    });
  });

  group('DetailState', () {
    test('DetailInitial is created correctly', () {
      const state = DetailInitial();
      expect(state, isA<DetailState>());
    });

    test('DetailLoading is created correctly', () {
      const state = DetailLoading();
      expect(state, isA<DetailState>());
    });

    test('DetailSuccess holds podcast', () {
      const podcast = PodcastDetailEntity(
        id: 'test-1',
        title: 'Test Podcast',
        publisher: 'Test Publisher',
        episodes: [],
      );
      const state = DetailSuccess(podcast);

      expect(state.podcast, podcast);
      expect(state.podcast.id, 'test-1');
    });

    test('DetailError holds message', () {
      const state = DetailError('Test error message');
      expect(state.message, 'Test error message');
    });
  });
}
