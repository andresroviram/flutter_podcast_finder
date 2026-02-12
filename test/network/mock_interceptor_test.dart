import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:podcast_finder/core/network/mock_interceptor.dart';

void main() {
  group('MockInterceptor Search', () {
    late Dio dio;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: 'http://test.com'));
      dio.interceptors.add(MockInterceptor());
    });

    test('search returns all podcasts regardless of query', () async {
      // Act
      final response = await dio.get('/search', queryParameters: {'q': ''});

      // Assert
      expect(response.statusCode, 200);
      expect(response.data['results'], isNotEmpty);
      expect(response.data['count'], equals(6)); // Todos los podcasts
      expect(response.data['results'].length, equals(6));
    });

    test('search returns all podcasts even with specific query', () async {
      // Act
      final response = await dio.get('/search', queryParameters: {'q': 'tech'});

      // Assert
      expect(response.statusCode, 200);
      expect(response.data['results'], isNotEmpty);
      expect(
        response.data['count'],
        equals(6),
      ); // Todos los podcasts sin filtrar
      expect(response.data['results'].length, equals(6));
    });

    test('search data contains expected podcast structure', () async {
      // Act
      final response = await dio.get('/search', queryParameters: {'q': 'test'});

      // Assert
      expect(response.statusCode, 200);
      final results = response.data['results'] as List;

      // Verify structure of first podcast
      final firstPodcast = results.first as Map<String, dynamic>;
      expect(firstPodcast.containsKey('id'), isTrue);
      expect(firstPodcast.containsKey('title'), isTrue);
      expect(firstPodcast.containsKey('publisher'), isTrue);
      expect(firstPodcast.containsKey('thumbnail'), isTrue);
      expect(firstPodcast.containsKey('description_original'), isTrue);
    });

    test('search returns expected podcasts', () async {
      // Act
      final response = await dio.get('/search', queryParameters: {'q': ''});

      // Assert
      expect(response.statusCode, 200);
      final results = response.data['results'] as List;

      final titles = results.map((p) => p['title'] as String).toList();
      expect(titles, contains('Tech Talk Daily'));
      expect(titles, contains('The Science Show'));
      expect(titles, contains('Business Builders'));
      expect(titles, contains('Tech Innovations'));
      expect(titles, contains('Science Fiction Stories'));
      expect(titles, contains('Business Daily'));
    });
  });
}
