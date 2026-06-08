import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManager {

  final dio = Dio();

  Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return dio.get(
      endPoint,
      queryParameters:  queryParameters,
      options: Options(
        validateStatus: (status) => true,
        headers: headers,
      ),
    );
  }

  Future<Response> postData({
    required String endPoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return dio.post(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        validateStatus: (status) => true,
        headers: headers,
      ),
    );
  }
}