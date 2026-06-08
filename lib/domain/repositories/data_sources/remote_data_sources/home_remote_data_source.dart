import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/services_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failures, List<ServicesResponseEntity>>> getServices();
}