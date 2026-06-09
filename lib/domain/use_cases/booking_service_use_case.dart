import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/booking_service_response_entity.dart';
import 'package:cure_app/domain/repositories/service_details/service_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookingServiceUseCase {
  ServiceDetailsRepository serviceDetailsRepository;

  BookingServiceUseCase({required this.serviceDetailsRepository});

  Future<Either<Failures, BookingServiceResponseEntity>> invoke({
    required String serviceId,
    required String serviceName,
    required String clinicalRemarks,
    required String address,
    required String date,
    required String time,
  }) {
    return serviceDetailsRepository.bookingService(
      serviceId: serviceId,
      serviceName: serviceName,
      clinicalRemarks: clinicalRemarks,
      address: address,
      date: date,
      time: time,
    );
  }
}
