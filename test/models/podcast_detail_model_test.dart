import 'package:flutter_test/flutter_test.dart';
import 'package:podcast_finder/features/home/data/models/podcast_detail_model.dart';
import 'package:podcast_finder/features/home/data/models/episode_model.dart';

void main() {
  group('PodcastDetailModel', () {
    test('fromJson creates valid model with episodes', () {
      // Arrange
      final json = {
        'id': 'podcast-1',
        'title': 'Test Podcast',
        'publisher': 'Test Publisher',
        'image': 'https://example.com/image.jpg',
        'description': 'Test description',
        'genre_ids': [127, 93],
        'episodes': [
          {
            'id': 'episode-1',
            'title': 'Episode 1',
            'description': 'Episode description',
            'pub_date_ms': 1702857600000,
            'audio_length_sec': 3600,
          },
          {
            'id': 'episode-2',
            'title': 'Episode 2',
            'pub_date_ms': 1702771200000,
            'audio_length_sec': 2700,
          },
        ],
      };

      // Act
      final podcast = PodcastDetailModel.fromJson(json);

      // Assert
      expect(podcast.id, 'podcast-1');
      expect(podcast.title, 'Test Podcast');
      expect(podcast.publisher, 'Test Publisher');
      expect(podcast.imageUrl, 'https://example.com/image.jpg');
      expect(podcast.description, 'Test description');
      expect(podcast.genreIds, [127, 93]);
      expect(podcast.episodes, isNotNull);
      expect(podcast.episodes!.length, 2);
      expect(podcast.episodes!.first.id, 'episode-1');
    });

    test('toJson creates valid JSON', () {
      // Arrange
      const podcast = PodcastDetailModel(
        id: 'podcast-1',
        title: 'Test Podcast',
        publisher: 'Test Publisher',
        imageUrl: 'https://example.com/image.jpg',
        description: 'Test description',
        genreIds: [127, 93],
        episodes: [
          EpisodeModel(
            id: 'episode-1',
            title: 'Episode 1',
            description: 'Episode description',
            pubDateMs: 1702857600000,
            audioLengthSec: 3600,
          ),
        ],
      );

      // Act
      final json = podcast.toJson();

      // Assert
      expect(json['id'], 'podcast-1');
      expect(json['title'], 'Test Podcast');
      expect(json['publisher'], 'Test Publisher');
      expect(json['image'], 'https://example.com/image.jpg');
      expect(json['description'], 'Test description');
      expect(json['genre_ids'], [127, 93]);
      expect(json['episodes'], isNotNull);
    });

    test('handles null optional fields', () {
      // Arrange
      final json = {
        'id': 'podcast-1',
        'title': 'Test Podcast',
        'publisher': 'Test Publisher',
      };

      // Act
      final podcast = PodcastDetailModel.fromJson(json);

      // Assert
      expect(podcast.imageUrl, isNull);
      expect(podcast.description, isNull);
      expect(podcast.genreIds, isNull);
      expect(podcast.episodes, isNull);
    });

    test('handles empty episodes list', () {
      // Arrange
      final json = {
        'id': 'podcast-1',
        'title': 'Test Podcast',
        'publisher': 'Test Publisher',
        'episodes': [],
      };

      // Act
      final podcast = PodcastDetailModel.fromJson(json);

      // Assert
      expect(podcast.episodes, isEmpty);
    });
  });
}
