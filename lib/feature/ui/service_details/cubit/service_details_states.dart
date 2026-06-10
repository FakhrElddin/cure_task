import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/booking_service_response_entity.dart';

abstract class ServiceDetailsStates {}

class ServiceDetailsInitStates extends ServiceDetailsStates {}

class ServiceDetailsLoadingStates extends ServiceDetailsStates {}

class ServiceDetailsSuccessStates extends ServiceDetailsStates {
  final BookingServiceResponseEntity bookingServiceResponseEntity;

  ServiceDetailsSuccessStates({required this.bookingServiceResponseEntity});
}

class ServiceDetailsErrorStates extends ServiceDetailsStates {
  final Failures failure;

  ServiceDetailsErrorStates({required this.failure});
}
