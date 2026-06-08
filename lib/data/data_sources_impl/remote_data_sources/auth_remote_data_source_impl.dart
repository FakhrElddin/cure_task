import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cure_app/core/api/api_manager.dart';
import 'package:cure_app/core/api/end_points.dart';
import 'package:cure_app/core/cache/shared_prefs_utils.dart';
import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/core/utils/app_constants.dart';
import 'package:cure_app/data/model/register_response_dm.dart';
import 'package:cure_app/domain/repositories/data_sources/remote_data_sources/auth_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiManager apiManager;

  AuthRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, RegisterResponseDM>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        var response = await apiManager.postData(
          endPoint: EndPoints.registerEndPoint,
          data: {
            "name": name,
            "email": email,
            "password": password,
            "phone": phone,
          },
        );
        if(response.data is Map<String, dynamic>){
          var registerResponse = RegisterResponseDM.fromJson(response.data);
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            await SharedPrefsUtils.saveData(
              key: AppConstants.userToken,
              value: registerResponse.token,
            );
            return Right(registerResponse);
          } else {
            return Left(
              ServerError(
                errorMessage: registerResponse.message ?? 'Register Failed.',
              ),
            );
          }
        } else {
          return Left(
            ServerError(
              errorMessage: 'Register Failed.',
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
