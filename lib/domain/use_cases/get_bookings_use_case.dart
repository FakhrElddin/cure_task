import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/booking_service_response_entity.dart';
import 'package:cure_app/domain/repositories/home/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBookingsUseCase {
  GetBookingsUseCase({required this.homeRepository});

  HomeRepository homeRepository;

  Future<Either<Failures, List<BookingServiceResponseEntity>>> invoke() {
    return homeRepository.getBookings();
  }
}
