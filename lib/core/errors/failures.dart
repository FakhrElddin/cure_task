import 'package:dio/dio.dart';

class Failures {
  String errorMessage;

  Failures({required this.errorMessage});
}

class ServerError extends Failures {
  ServerError({required super.errorMessage});

  factory ServerError.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerError(errorMessage: "Connection timeout with API server");
      case DioExceptionType.sendTimeout:
        return ServerError(
          errorMessage: "Send timeout in connection with API server",
        );
      case DioExceptionType.receiveTimeout:
        return ServerError(
          errorMessage: "Receive timeout in connection with API server",
        );
      case DioExceptionType.cancel:
        return ServerError(errorMessage: "Request to API server was cancelled");
      case DioExceptionType.connectionError:
        return ServerError(
          errorMessage: "No Internet Connection or Server Refused",
        );
      default:
        return ServerError(
          errorMessage: "Something went wrong, please try again",
        );
    }
  }
}

class NetworkError extends Failures {
  NetworkError({
    super.errorMessage = 'No Internet Connection, Please Check Your Network',
  });
}
