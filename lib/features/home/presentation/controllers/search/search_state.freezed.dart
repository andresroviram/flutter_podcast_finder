// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState()';
}


}

/// @nodoc
class $SearchStateCopyWith<$Res>  {
$SearchStateCopyWith(SearchState _, $Res Function(SearchState) __);
}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchInitial value)?  initial,TResult Function( SearchLoading value)?  loading,TResult Function( SearchSuccess value)?  success,TResult Function( SearchEmpty value)?  empty,TResult Function( SearchError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchInitial() when initial != null:
return initial(_that);case SearchLoading() when loading != null:
return loading(_that);case SearchSuccess() when success != null:
return success(_that);case SearchEmpty() when empty != null:
return empty(_that);case SearchError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchInitial value)  initial,required TResult Function( SearchLoading value)  loading,required TResult Function( SearchSuccess value)  success,required TResult Function( SearchEmpty value)  empty,required TResult Function( SearchError value)  error,}){
final _that = this;
switch (_that) {
case SearchInitial():
return initial(_that);case SearchLoading():
return loading(_that);case SearchSuccess():
return success(_that);case SearchEmpty():
return empty(_that);case SearchError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchInitial value)?  initial,TResult? Function( SearchLoading value)?  loading,TResult? Function( SearchSuccess value)?  success,TResult? Function( SearchEmpty value)?  empty,TResult? Function( SearchError value)?  error,}){
final _that = this;
switch (_that) {
case SearchInitial() when initial != null:
return initial(_that);case SearchLoading() when loading != null:
return loading(_that);case SearchSuccess() when success != null:
return success(_that);case SearchEmpty() when empty != null:
return empty(_that);case SearchError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<PodcastEntity> podcasts,  String query)?  success,TResult Function( String query)?  empty,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchInitial() when initial != null:
return initial();case SearchLoading() when loading != null:
return loading();case SearchSuccess() when success != null:
return success(_that.podcasts,_that.query);case SearchEmpty() when empty != null:
return empty(_that.query);case SearchError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<PodcastEntity> podcasts,  String query)  success,required TResult Function( String query)  empty,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SearchInitial():
return initial();case SearchLoading():
return loading();case SearchSuccess():
return success(_that.podcasts,_that.query);case SearchEmpty():
return empty(_that.query);case SearchError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<PodcastEntity> podcasts,  String query)?  success,TResult? Function( String query)?  empty,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SearchInitial() when initial != null:
return initial();case SearchLoading() when loading != null:
return loading();case SearchSuccess() when success != null:
return success(_that.podcasts,_that.query);case SearchEmpty() when empty != null:
return empty(_that.query);case SearchError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SearchInitial implements SearchState {
  const SearchInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState.initial()';
}


}




/// @nodoc


class SearchLoading implements SearchState {
  const SearchLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState.loading()';
}


}




/// @nodoc


class SearchSuccess implements SearchState {
  const SearchSuccess(final  List<PodcastEntity> podcasts, this.query): _podcasts = podcasts;
  

 final  List<PodcastEntity> _podcasts;
 List<PodcastEntity> get podcasts {
  if (_podcasts is EqualUnmodifiableListView) return _podcasts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_podcasts);
}

 final  String query;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchSuccessCopyWith<SearchSuccess> get copyWith => _$SearchSuccessCopyWithImpl<SearchSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSuccess&&const DeepCollectionEquality().equals(other._podcasts, _podcasts)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_podcasts),query);

@override
String toString() {
  return 'SearchState.success(podcasts: $podcasts, query: $query)';
}


}

/// @nodoc
abstract mixin class $SearchSuccessCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory $SearchSuccessCopyWith(SearchSuccess value, $Res Function(SearchSuccess) _then) = _$SearchSuccessCopyWithImpl;
@useResult
$Res call({
 List<PodcastEntity> podcasts, String query
});




}
/// @nodoc
class _$SearchSuccessCopyWithImpl<$Res>
    implements $SearchSuccessCopyWith<$Res> {
  _$SearchSuccessCopyWithImpl(this._self, this._then);

  final SearchSuccess _self;
  final $Res Function(SearchSuccess) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? podcasts = null,Object? query = null,}) {
  return _then(SearchSuccess(
null == podcasts ? _self._podcasts : podcasts // ignore: cast_nullable_to_non_nullable
as List<PodcastEntity>,null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SearchEmpty implements SearchState {
  const SearchEmpty(this.query);
  

 final  String query;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchEmptyCopyWith<SearchEmpty> get copyWith => _$SearchEmptyCopyWithImpl<SearchEmpty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchEmpty&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'SearchState.empty(query: $query)';
}


}

/// @nodoc
abstract mixin class $SearchEmptyCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory $SearchEmptyCopyWith(SearchEmpty value, $Res Function(SearchEmpty) _then) = _$SearchEmptyCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$SearchEmptyCopyWithImpl<$Res>
    implements $SearchEmptyCopyWith<$Res> {
  _$SearchEmptyCopyWithImpl(this._self, this._then);

  final SearchEmpty _self;
  final $Res Function(SearchEmpty) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(SearchEmpty(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SearchError implements SearchState {
  const SearchError(this.message);
  

 final  String message;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchErrorCopyWith<SearchError> get copyWith => _$SearchErrorCopyWithImpl<SearchError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SearchState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SearchErrorCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory $SearchErrorCopyWith(SearchError value, $Res Function(SearchError) _then) = _$SearchErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SearchErrorCopyWithImpl<$Res>
    implements $SearchErrorCopyWith<$Res> {
  _$SearchErrorCopyWithImpl(this._self, this._then);

  final SearchError _self;
  final $Res Function(SearchError) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SearchError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
