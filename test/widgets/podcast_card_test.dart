import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:podcast_finder/features/home/domain/entities/entities.dart';
import 'package:podcast_finder/features/home/presentation/widgets/podcast_card.dart';

void main() {
  group('PodcastCard Widget', () {
    testWidgets('displays podcast information correctly', (tester) async {
      // Arrange
      const podcast = PodcastEntity(
        id: 'test-1',
        title: 'Test Podcast',
        publisher: 'Test Publisher',
        imageUrl: 'https://example.com/image.jpg',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PodcastCard(podcast: podcast, onTap: () {}),
          ),
        ),
      );

      // Assert
      expect(find.text('Test Podcast'), findsOneWidget);
      expect(find.text('Test Publisher'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('displays without description when null', (tester) async {
      // Arrange
      const podcast = PodcastEntity(
        id: 'test-1',
        title: 'Test Podcast',
        publisher: 'Test Publisher',
        imageUrl: 'https://example.com/image.jpg',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PodcastCard(podcast: podcast, onTap: () {}),
          ),
        ),
      );

      // Assert
      expect(find.text('Test Podcast'), findsOneWidget);
      expect(find.text('Test Publisher'), findsOneWidget);
      // Description should not be present
      expect(find.byType(Text), findsNWidgets(2)); // Only title and publisher
    });

    testWidgets('calls onTap when tapped', (tester) async {
      // Arrange
      const podcast = PodcastEntity(
        id: 'test-1',
        title: 'Test Podcast',
        publisher: 'Test Publisher',
      );
      var tapped = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PodcastCard(
              podcast: podcast,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PodcastCard));
      await tester.pumpAndSettle();

      // Assert
      expect(tapped, isTrue);
    });

    testWidgets('displays placeholder when imageUrl is null', (tester) async {
      // Arrange
      const podcast = PodcastEntity(
        id: 'test-1',
        title: 'Test Podcast',
        publisher: 'Test Publisher',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PodcastCard(podcast: podcast, onTap: () {}),
          ),
        ),
      );

      // Assert - Should find the podcast icon placeholder
      expect(find.byIcon(Icons.podcasts), findsOneWidget);
    });

    testWidgets('title is truncated after 2 lines', (tester) async {
      // Arrange
      const podcast = PodcastEntity(
        id: 'test-1',
        title:
            'This is a very long podcast title that should be truncated after two lines of text',
        publisher: 'Test Publisher',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PodcastCard(podcast: podcast, onTap: () {}),
          ),
        ),
      );

      // Assert - Find the title text widget and verify maxLines
      final titleFinder = find.text(podcast.title);
      expect(titleFinder, findsOneWidget);

      final titleWidget = tester.widget<Text>(titleFinder);
      expect(titleWidget.maxLines, 2);
      expect(titleWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('publisher is truncated after 1 line', (tester) async {
      // Arrange
      const podcast = PodcastEntity(
        id: 'test-1',
        title: 'Test Podcast',
        publisher:
            'This is a very long publisher name that should be truncated',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PodcastCard(podcast: podcast, onTap: () {}),
          ),
        ),
      );

      // Assert - Find the publisher text widget and verify maxLines
      final publisherFinder = find.text(podcast.publisher);
      expect(publisherFinder, findsOneWidget);

      final publisherWidget = tester.widget<Text>(publisherFinder);
      expect(publisherWidget.maxLines, 1);
      expect(publisherWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('has correct card styling', (tester) async {
      // Arrange
      const podcast = PodcastEntity(
        id: 'test-1',
        title: 'Test Podcast',
        publisher: 'Test Publisher',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PodcastCard(podcast: podcast, onTap: () {}),
          ),
        ),
      );

      // Assert - Find the Card widget and verify properties
      final cardFinder = find.byType(Card);
      expect(cardFinder, findsOneWidget);

      final card = tester.widget<Card>(cardFinder);
      final shape = card.shape as RoundedRectangleBorder;
      expect(shape.borderRadius, BorderRadius.circular(12));
      expect(shape.side.width, 1);
      expect(shape.side.color, const Color(0xFFDEE2E6));
    });
  });
}
