import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/entities.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = SearchInitial;
  const factory SearchState.loading() = SearchLoading;
  const factory SearchState.success(
    List<PodcastEntity> podcasts,
    String query,
  ) = SearchSuccess;
  const factory SearchState.empty(String query) = SearchEmpty;
  const factory SearchState.error(String message) = SearchError;
}
