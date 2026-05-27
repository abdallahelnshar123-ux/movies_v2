import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'dio_interceptors.dart';
import 'end_points.dart';

@module
abstract class GetItModule {
  @singleton
  BaseOptions get baseOptions => BaseOptions(
    baseUrl: EndPoints.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  );

  @singleton
  PrettyDioLogger get prettyDioLogger => PrettyDioLogger(
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
    request: true,
    error: true,
  );

  @singleton
  Dio provideDio(BaseOptions baseOptions, PrettyDioLogger prettyDioLogger) {
    Dio dio = Dio(baseOptions);
    dio.interceptors.add(DioInterceptors());
    dio.interceptors.add(prettyDioLogger);
    return dio;
  }
}
