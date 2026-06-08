import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/register_response_entity.dart';
import 'package:cure_app/domain/repositories/auth/auth_repository.dart';
import 'package:cure_app/domain/repositories/data_sources/remote_data_sources/auth_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failures, RegisterResponseEntity>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    var either = await authRemoteDataSource.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
