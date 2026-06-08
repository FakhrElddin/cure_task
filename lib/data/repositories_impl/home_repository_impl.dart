import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/services_response_entity.dart';
import 'package:cure_app/domain/repositories/data_sources/remote_data_sources/home_remote_data_source.dart';
import 'package:cure_app/domain/repositories/home/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository{
  HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failures, List<ServicesResponseEntity>>> getServices() async{
    var either = await homeRemoteDataSource.getServices();
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}