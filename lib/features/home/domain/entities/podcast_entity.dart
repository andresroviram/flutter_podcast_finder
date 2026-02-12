part of 'entities.dart';

class PodcastEntity extends Equatable {
  final String id;
  final String title;
  final String publisher;
  final String? imageUrl;
  final String? thumbnailUrl;
  final String? description;

  const PodcastEntity({
    required this.id,
    required this.title,
    required this.publisher,
    this.imageUrl,
    this.thumbnailUrl,
    this.description,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    publisher,
    imageUrl,
    thumbnailUrl,
    description,
  ];
}
