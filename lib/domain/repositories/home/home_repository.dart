import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/booking_service_response_entity.dart';
import 'package:cure_app/domain/entities/services_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failures, List<ServicesResponseEntity>>> getServices();

  Future<Either<Failures, List<BookingServiceResponseEntity>>> getBookings();
}