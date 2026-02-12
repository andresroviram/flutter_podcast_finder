import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:podcast_finder/features/home/domain/entities/entities.dart';
import 'package:podcast_finder/features/home/presentation/controllers/search/search_notifier.dart';
import 'package:podcast_finder/features/home/presentation/providers/podcast/podcast_provider.dart';
import 'package:podcast_finder/features/home/domain/usecases/podcast_usecases.dart';

class MockPodcastUseCase extends Mock implements PodcastUseCase {}

void main() {
  group('SearchNotifier Filtering', () {
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

    test('filterPodcastsByTitle filters by title case-insensitive', () {
      // Arrange
      final podcasts = [
        const PodcastEntity(
          id: '1',
          title: 'Tech Talk Daily',
          publisher: 'Publisher 1',
        ),
        const PodcastEntity(
          id: '2',
          title: 'The Science Show',
          publisher: 'Publisher 2',
        ),
        const PodcastEntity(
          id: '3',
          title: 'Tech Innovations',
          publisher: 'Publisher 3',
        ),
      ];

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      final filtered = notifier.filterPodcastsByTitle(podcasts, 'tech');

      // Assert
      expect(filtered.length, equals(2));
      expect(
        filtered.map((p) => p.title),
        containsAll(['Tech Talk Daily', 'Tech Innovations']),
      );
    });

    test('filterPodcastsByTitle is case insensitive', () {
      // Arrange
      final podcasts = [
        const PodcastEntity(
          id: '1',
          title: 'Tech Talk Daily',
          publisher: 'Publisher 1',
        ),
        const PodcastEntity(
          id: '2',
          title: 'The Science Show',
          publisher: 'Publisher 2',
        ),
      ];

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act - Test with different cases
      final filteredLower = notifier.filterPodcastsByTitle(podcasts, 'tech');
      final filteredUpper = notifier.filterPodcastsByTitle(podcasts, 'TECH');
      final filteredMixed = notifier.filterPodcastsByTitle(podcasts, 'TeCh');

      // Assert - All should return the same results
      expect(filteredLower.length, equals(1));
      expect(filteredUpper.length, equals(1));
      expect(filteredMixed.length, equals(1));
    });

    test('filterPodcastsByTitle returns all when query is empty', () {
      // Arrange
      final podcasts = [
        const PodcastEntity(
          id: '1',
          title: 'Tech Talk Daily',
          publisher: 'Publisher 1',
        ),
        const PodcastEntity(
          id: '2',
          title: 'The Science Show',
          publisher: 'Publisher 2',
        ),
      ];

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      final filtered = notifier.filterPodcastsByTitle(podcasts, '');

      // Assert
      expect(filtered.length, equals(2));
    });

    test('filterPodcastsByTitle returns empty when no match', () {
      // Arrange
      final podcasts = [
        const PodcastEntity(
          id: '1',
          title: 'Tech Talk Daily',
          publisher: 'Publisher 1',
        ),
        const PodcastEntity(
          id: '2',
          title: 'The Science Show',
          publisher: 'Publisher 2',
        ),
      ];

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      final filtered = notifier.filterPodcastsByTitle(
        podcasts,
        'xyz123notfound',
      );

      // Assert
      expect(filtered, isEmpty);
    });

    test('filterPodcastsByTitle matches partial words', () {
      // Arrange
      final podcasts = [
        const PodcastEntity(
          id: '1',
          title: 'Tech Talk Daily',
          publisher: 'Publisher 1',
        ),
        const PodcastEntity(
          id: '2',
          title: 'Business Daily',
          publisher: 'Publisher 2',
        ),
        const PodcastEntity(
          id: '3',
          title: 'Science Weekly',
          publisher: 'Publisher 3',
        ),
      ];

      final notifier = container.read(searchNotifierProvider.notifier);

      // Act
      final filtered = notifier.filterPodcastsByTitle(podcasts, 'daily');

      // Assert
      expect(filtered.length, equals(2));
      expect(
        filtered.map((p) => p.title),
        containsAll(['Tech Talk Daily', 'Business Daily']),
      );
    });
  });
}
