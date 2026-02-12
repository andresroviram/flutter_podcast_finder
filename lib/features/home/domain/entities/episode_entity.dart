part of 'entities.dart';

class EpisodeEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final int pubDateMs;
  final int audioLengthSec;
  final String? audio;

  const EpisodeEntity({
    required this.id,
    required this.title,
    this.description,
    required this.pubDateMs,
    required this.audioLengthSec,
    this.audio,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    pubDateMs,
    audioLengthSec,
    audio,
  ];
}
