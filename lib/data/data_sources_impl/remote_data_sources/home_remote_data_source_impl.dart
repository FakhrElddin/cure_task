import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cure_app/core/api/api_manager.dart';
import 'package:cure_app/core/api/end_points.dart';
import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/data/model/services_response_dm.dart';
import 'package:cure_app/domain/repositories/data_sources/remote_data_sources/home_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  ApiManager apiManager;

  HomeRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, List<ServicesResponseDM>>> getServices() async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        var response = await apiManager.getData(
          endPoint: EndPoints.getServicesEndPoint,
        );
        if (response.data is List<dynamic>) {
          List<dynamic> data = response.data;
          List<ServicesResponseDM> servicesResponse = data.map((service) {
            return ServicesResponseDM.fromJson(service);
          }).toList();
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            return Right(servicesResponse);
          } else {
            return Left(ServerError(errorMessage: 'Failed To Get Data1.'));
          }
        } else {
          return Left(ServerError(errorMessage: 'Failed To Get Data.'));
        }
      } else {
        return Left(NetworkError());
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerError.fromDioException(e));
      }
      return Left(Failures(errorMessage: e.toString()));
    }
  }
}
