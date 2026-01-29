import 'package:podcast_finder/core/error/failures.dart';

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Failure<T> extends Result<T> {
  final Failures error;
  const Failure(this.error);
}

extension ResultX<T> on Result<T> {
  Result<R> map<R>(R Function(T value) transform) {
    switch (this) {
      case Success<T>(:final value):
        return Success(transform(value));
      case Failure<T>(:final error):
        return Failure(error);
    }
  }

  Result<R> flatMap<R>(Result<R> Function(T value) transform) {
    switch (this) {
      case Success<T>(:final value):
        return transform(value);
      case Failure<T>(:final error):
        return Failure(error);
    }
  }

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Failures error) onFailure,
  }) {
    switch (this) {
      case Success<T>(:final value):
        return onSuccess(value);
      case Failure<T>(:final error):
        return onFailure(error);
    }
  }
}
