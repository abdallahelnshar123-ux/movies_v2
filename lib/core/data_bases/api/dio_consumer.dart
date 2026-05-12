import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'api_consumer.dart';

@Injectable(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio);

  @override
  Future<dynamic> get(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
      }) async {
    final response = await dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<dynamic> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFormData = false,
      }) async {
    final response = await dio.post(
      path,
      data: isFormData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<dynamic> patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFormData = false,
      }) async {
    final response = await dio.patch(
      path,
      data: isFormData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<dynamic> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
      }) async {
    final response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return response.data;
  }
}