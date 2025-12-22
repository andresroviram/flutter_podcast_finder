import '../../../domain/entities/entities.dart';

abstract class DetailState {
  const DetailState();
}

class DetailInitial extends DetailState {
  const DetailInitial();
}

class DetailLoading extends DetailState {
  const DetailLoading();
}

class DetailSuccess extends DetailState {
  final PodcastDetailEntity podcast;

  const DetailSuccess(this.podcast);
}

class DetailError extends DetailState {
  final String message;

  const DetailError(this.message);
}
