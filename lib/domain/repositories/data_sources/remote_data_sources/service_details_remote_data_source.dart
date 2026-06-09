import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/booking_service_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ServiceDetailsRemoteDataSource {
  Future<Either<Failures, BookingServiceResponseEntity>> bookingService({
    required String serviceId,
    required String serviceName,
    required String clinicalRemarks,
    required String address,
    required String date,
    required String time,
  });
}
