import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/booking_service_response_entity.dart';

abstract class BookingsTabStates {}

class BookingTabInitState extends BookingsTabStates {}

class BookingsTabLoadingState extends BookingsTabStates {}

class BookingsTabSuccessState extends BookingsTabStates {
  final List<BookingServiceResponseEntity> bookings;

  BookingsTabSuccessState({required this.bookings});
}

class BookingsTabErrorState extends BookingsTabStates {
  final Failures failure;

  BookingsTabErrorState({required this.failure});
}
