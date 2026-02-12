import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  final String message;
  final int? statusCode;

  const Failures({required this.message, this.statusCode});
  @override
  List<Object?> get props => [message, statusCode];
}

// Network failures
class NetworkFailure extends Failures {
  const NetworkFailure({
    super.message = 'No internet connection',
    super.statusCode,
  });
}

class ServerFailure extends Failures {
  const ServerFailure({
    super.message = 'Server error occurred',
    super.statusCode,
  });
}

class TimeoutFailure extends Failures {
  const TimeoutFailure({
    super.message = 'Connection timeout',
    super.statusCode,
  });
}

// Data failures
class CacheFailure extends Failures {
  const CacheFailure({super.message = 'Cache failure', super.statusCode});
}

class ValidationFailure extends Failures {
  const ValidationFailure({
    super.message = 'Validation error',
    super.statusCode,
  });
}

// Auth failures
class AuthFailure extends Failures {
  const AuthFailure({
    super.message = 'Authentication failed',
    super.statusCode,
  });
}

class UnauthorizedFailure extends Failures {
  const UnauthorizedFailure({
    super.message = 'Unauthorized access',
    super.statusCode,
  });
}

class InputFailure extends Failures {
  const InputFailure({super.message = 'Invalid input', super.statusCode});
}
