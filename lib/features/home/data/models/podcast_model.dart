import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/entities.dart';

part 'podcast_model.g.dart';

@JsonSerializable()
class PodcastModel {
  final String id;
  final String title;
  final String publisher;

  @JsonKey(name: 'thumbnail')
  final String? imageUrl;

  @JsonKey(name: 'description_original')
  final String? description;

  const PodcastModel({
    required this.id,
    required this.title,
    required this.publisher,
    this.imageUrl,
    this.description,
  });

  factory PodcastModel.fromJson(Map<String, dynamic> json) =>
      _$PodcastModelFromJson(json);

  Map<String, dynamic> toJson() => _$PodcastModelToJson(this);
}

extension PodcastModelMapper on PodcastModel {
  PodcastEntity toEntity() => PodcastEntity(
    id: id,
    title: title,
    publisher: publisher,
    imageUrl: imageUrl,
    description: description,
  );
}
