import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/entities.dart';

part 'detail_state.freezed.dart';

@freezed
class DetailState with _$DetailState {
  const factory DetailState.initial() = DetailInitial;
  const factory DetailState.loading() = DetailLoading;
  const factory DetailState.success(PodcastDetailEntity podcast) =
      DetailSuccess;
  const factory DetailState.error(String message) = DetailError;
}
