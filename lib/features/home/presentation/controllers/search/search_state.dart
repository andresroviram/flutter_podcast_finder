import '../../../domain/entities/entities.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchSuccess extends SearchState {
  final List<PodcastEntity> podcasts;
  final String query;

  const SearchSuccess(this.podcasts, this.query);
}

class SearchEmpty extends SearchState {
  final String query;

  const SearchEmpty(this.query);
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);
}
