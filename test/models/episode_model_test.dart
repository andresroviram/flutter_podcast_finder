import 'package:flutter_test/flutter_test.dart';
import 'package:podcast_finder/features/home/data/models/episode_model.dart';
import 'package:podcast_finder/core/utils/formatters.dart';

void main() {
  group('EpisodeModel', () {
    test('fromJson creates valid model', () {
      // Arrange
      final json = {
        'id': 'episode-1',
        'title': 'Test Episode',
        'description': 'Test description',
        'pub_date_ms': 1702857600000, // Dec 18, 2023
        'audio_length_sec': 3600, // 1 hour
      };

      // Act
      final episode = EpisodeModel.fromJson(json);

      // Assert
      expect(episode.id, 'episode-1');
      expect(episode.title, 'Test Episode');
      expect(episode.description, 'Test description');
      expect(episode.pubDateMs, 1702857600000);
      expect(episode.audioLengthSec, 3600);
    });

    test('toJson creates valid JSON', () {
      // Arrange
      const episode = EpisodeModel(
        id: 'episode-1',
        title: 'Test Episode',
        description: 'Test description',
        pubDateMs: 1702857600000,
        audioLengthSec: 3600,
      );

      // Act
      final json = episode.toJson();

      // Assert
      expect(json['id'], 'episode-1');
      expect(json['title'], 'Test Episode');
      expect(json['description'], 'Test description');
      expect(json['pub_date_ms'], 1702857600000);
      expect(json['audio_length_sec'], 3600);
    });

    test('formattedDate returns correct format', () {
      // Arrange - Using a UTC timestamp to avoid timezone issues
      // Dec 16, 2023 at noon UTC
      const episode = EpisodeModel(
        id: 'episode-1',
        title: 'Test Episode',
        pubDateMs: 1702728000000, // Dec 16, 2023 12:00:00 UTC
        audioLengthSec: 3600,
      );

      // Act
      final formattedDate = formatDate(episode.pubDateMs);

      // Assert - Check that it contains the expected date components
      expect(formattedDate, contains('Dec'));
      expect(formattedDate, contains('2023'));
      // The day might be 15 or 16 depending on timezone, so we're more flexible
      expect(
        formattedDate.contains('15') || formattedDate.contains('16'),
        isTrue,
      );
    });

    test('formattedDuration returns hours and minutes', () {
      // Arrange - 1h 30m
      const episode = EpisodeModel(
        id: 'episode-1',
        title: 'Test Episode',
        pubDateMs: 1702684800000,
        audioLengthSec: 5400, // 90 minutes
      );

      // Act
      final formattedDuration = formatDuration(episode.audioLengthSec);

      // Assert
      expect(formattedDuration, '1h 30m');
    });

    test('formattedDuration returns only hours when no remaining minutes', () {
      // Arrange - 2h
      const episode = EpisodeModel(
        id: 'episode-1',
        title: 'Test Episode',
        pubDateMs: 1702684800000,
        audioLengthSec: 7200, // 2 hours exactly
      );

      // Act
      final formattedDuration = formatDuration(episode.audioLengthSec);

      // Assert
      expect(formattedDuration, '2h');
    });

    test('formattedDuration returns only minutes when less than 1 hour', () {
      // Arrange - 45 min
      const episode = EpisodeModel(
        id: 'episode-1',
        title: 'Test Episode',
        pubDateMs: 1702684800000,
        audioLengthSec: 2700, // 45 minutes
      );

      // Act
      final formattedDuration = formatDuration(episode.audioLengthSec);

      // Assert
      expect(formattedDuration, '45 min');
    });

    test('handles null description', () {
      // Arrange
      final json = {
        'id': 'episode-1',
        'title': 'Test Episode',
        'pub_date_ms': 1702857600000,
        'audio_length_sec': 3600,
      };

      // Act
      final episode = EpisodeModel.fromJson(json);

      // Assert
      expect(episode.description, isNull);
    });
  });
}
