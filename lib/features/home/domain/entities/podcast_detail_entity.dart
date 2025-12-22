part of 'entities.dart';

class PodcastDetailEntity extends Equatable {
  final String id;
  final String title;
  final String publisher;
  final String? description;
  final String? imageUrl;
  final String? thumbnailUrl;
  final List<EpisodeEntity> episodes;
  final List<int>? genreIds;

  const PodcastDetailEntity({
    required this.id,
    required this.title,
    required this.publisher,
    this.genreIds,
    this.description,
    this.imageUrl,
    this.thumbnailUrl,
    required this.episodes,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    publisher,
    description,
    imageUrl,
    thumbnailUrl,
    episodes,
    genreIds,
  ];
}
