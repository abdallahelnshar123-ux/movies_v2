import '../../domain/failure/failure.dart';
import 'app_exceptions.dart';

extension ExceptionMapper on AppException {
  Failure toFailure() {
    switch (runtimeType) {
      case NetworkException _:
        return NetworkFailure(message);
      case ServerException _:
        return ServerFailure(message);
      default:
        return UnexpectedFailure(message);
    }
  }
}