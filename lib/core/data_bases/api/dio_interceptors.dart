import 'package:dio/dio.dart';

import '../../../data/exceptions/app_exceptions.dart';

class DioInterceptors extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException exception;
    final responseData = err.response?.data;
    String message = 'Some thing went wrong';
    if (responseData is Map) {
      message =
          responseData['error']?['msg'] ?? responseData['error'] ?? message;
    }

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        exception = const NetworkException(
          message: 'Please check your internet connection',
        );
        break;

      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 401:
            exception = UnauthorizedException(
              message: message,
              statusCode: 401,
            );
            break;

          default:
            exception = ServerException(
              message: message,
              statusCode: err.response?.statusCode,
            );
        }
        break;

      case DioExceptionType.cancel:
        exception = const CancelledByUserException();
        break;

      default:
        exception = UnexpectedException(message: message);
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        response: err.response,
        type: err.type,
      ),
    );
  }
}
