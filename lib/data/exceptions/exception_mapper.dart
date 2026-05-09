import '../../domain/failure/failure.dart';
import 'app_exceptions.dart';

extension ExceptionMapper on AppException {
  Failure toFailure() {
    if (this is NetworkException) {
      return NetworkFailure(message);
    }

    if (this is ServerException) {
      return ServerFailure(message);
    }
    if (this is CancelledByUserException) {
      return AuthFailure(message);
    }

    return UnexpectedFailure(message);
  }
}
