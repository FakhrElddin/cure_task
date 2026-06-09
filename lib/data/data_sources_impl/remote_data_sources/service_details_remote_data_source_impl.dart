import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cure_app/core/api/api_manager.dart';
import 'package:cure_app/core/api/end_points.dart';
import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/data/model/booking_service_response_dm.dart';
import 'package:cure_app/domain/repositories/data_sources/remote_data_sources/service_details_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ServiceDetailsRemoteDataSource)
class ServiceDetailsRemoteDataSourceImpl implements ServiceDetailsRemoteDataSource{
  ServiceDetailsRemoteDataSourceImpl({required this.apiManager});
  ApiManager apiManager;
  @override
  Future<Either<Failures, BookingServiceResponseDM>> bookingService({
    required String serviceId,
    required String serviceName,
    required String clinicalRemarks,
    required String address,
    required String date,
    required String time,
  }) async{
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        var response = await apiManager.postData(
          endPoint: EndPoints.bookingEndPoint,
          data: {
            "createdAt": DateTime.now().toString(),
            "serviceId": serviceId,
            "serviceName": serviceName,
            "clinicalRemarks": clinicalRemarks,
            "address": address,
            "date": date,
            "time": time,
            "status": "pending"
          },
        );
        if(response.data is Map<String, dynamic>){
          var bookingResponse = BookingServiceResponseDM.fromJson(response.data);
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            return Right(bookingResponse);
          } else {
            return Left(
              ServerError(
                errorMessage: 'Failed To Book Service.',
              ),
            );
          }
        } else {
          return Left(
            ServerError(
              errorMessage: 'Failed To Book Service.',
            ),
          );
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