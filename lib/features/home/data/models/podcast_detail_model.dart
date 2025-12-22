import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/entities.dart';
import 'episode_model.dart';

part 'podcast_detail_model.g.dart';

@JsonSerializable()
class PodcastDetailModel {
  final String id;
  final String title;
  final String publisher;

  @JsonKey(name: 'image')
  final String? imageUrl;

  final String? description;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  final List<EpisodeModel>? episodes;

  const PodcastDetailModel({
    required this.id,
    required this.title,
    required this.publisher,
    this.imageUrl,
    this.description,
    this.genreIds,
    this.episodes,
  });

  factory PodcastDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PodcastDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PodcastDetailModelToJson(this);
}

extension PodcastDetailModelMapper on PodcastDetailModel {
  PodcastDetailEntity toEntity() => PodcastDetailEntity(
    id: id,
    title: title,
    publisher: publisher,
    imageUrl: imageUrl,
    description: description,
    genreIds: genreIds,
    episodes: episodes?.map((episode) => episode.toEntity()).toList() ?? [],
  );
}
