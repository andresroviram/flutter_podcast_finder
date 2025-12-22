import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/entities.dart';

part 'episode_model.g.dart';

@JsonSerializable()
class EpisodeModel {
  final String id;
  final String title;
  final String? description;

  @JsonKey(name: 'pub_date_ms')
  final int pubDateMs;

  @JsonKey(name: 'audio_length_sec')
  final int audioLengthSec;

  const EpisodeModel({
    required this.id,
    required this.title,
    this.description,
    required this.pubDateMs,
    required this.audioLengthSec,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeModelToJson(this);
}

extension EpisodeModelMapper on EpisodeModel {
  EpisodeEntity toEntity() => EpisodeEntity(
    id: id,
    title: title,
    description: description,
    pubDateMs: pubDateMs,
    audioLengthSec: audioLengthSec,
  );
}
