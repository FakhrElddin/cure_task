import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/services_response_entity.dart';
import 'package:cure_app/domain/repositories/home/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetServicesUseCase {
  HomeRepository homeRepository;
  GetServicesUseCase({required this.homeRepository});

  Future<Either<Failures, List<ServicesResponseEntity>>> invoke(){
    return homeRepository.getServices();
  }
}