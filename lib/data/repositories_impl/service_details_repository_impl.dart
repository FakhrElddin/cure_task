import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/booking_service_response_entity.dart';
import 'package:cure_app/domain/repositories/data_sources/remote_data_sources/service_details_remote_data_source.dart';
import 'package:cure_app/domain/repositories/service_details/service_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ServiceDetailsRepository)
class ServiceDetailsRepositoryImpl implements ServiceDetailsRepository {
  ServiceDetailsRemoteDataSource serviceDetailsRemoteDataSource;

  ServiceDetailsRepositoryImpl({required this.serviceDetailsRemoteDataSource});

  @override
  Future<Either<Failures, BookingServiceResponseEntity>> bookingService({
    required String serviceId,
    required String serviceName,
    required String clinicalRemarks,
    required String address,
    required String date,
    required String time,
    required String servicePrice,
  }) async {
    var either = await serviceDetailsRemoteDataSource.bookingService(
      serviceId: serviceId,
      serviceName: serviceName,
      clinicalRemarks: clinicalRemarks,
      address: address,
      date: date,
      time: time,
      servicePrice: servicePrice,
    );
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
