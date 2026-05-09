abstract class AppException implements Exception {
  final String message;

  final int? statusCode;

  const AppException({required this.message, required this.statusCode});
}

class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode});
}

class NetworkException extends AppException {
  const NetworkException({required super.message, super.statusCode});
}

class CancelledByUserException extends AppException {
  const CancelledByUserException()
    : super(message: 'Cancelled by user', statusCode: null);
}

class UnexpectedException extends AppException {
  const UnexpectedException({required super.message, super.statusCode});
}
