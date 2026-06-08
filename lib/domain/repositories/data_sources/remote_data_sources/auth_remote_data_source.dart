import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/register_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failures, RegisterResponseEntity>> register({required String name, required String email, required String password, required String phone});

}