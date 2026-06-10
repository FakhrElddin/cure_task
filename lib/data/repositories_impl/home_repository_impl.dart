import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/booking_service_response_entity.dart';
import 'package:cure_app/domain/entities/services_response_entity.dart';
import 'package:cure_app/domain/repositories/data_sources/offline_data_sources/home_offline_data_source.dart';
import 'package:cure_app/domain/repositories/data_sources/remote_data_sources/home_remote_data_source.dart';
import 'package:cure_app/domain/repositories/home/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeRemoteDataSource homeRemoteDataSource;
  HomeOfflineDataSource homeOfflineDataSource;

  HomeRepositoryImpl({
    required this.homeRemoteDataSource,
    required this.homeOfflineDataSource,
  });

  @override
  Future<Either<Failures, List<ServicesResponseEntity>>> getServices() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity()
        .checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      var either = await homeRemoteDataSource.getServices();
      return either.fold((error) => Left(error), (response) {
        homeOfflineDataSource.saveServicesOffline(
          servicesResponseEntityList: response,
        );
        return Right(response);
      });
    } else {
      var either = await homeOfflineDataSource.getServicesFromCache();
      return either.fold((error) => Left(error), (response) => Right(response));
    }
  }

  @override
  Future<Either<Failures, List<BookingServiceResponseEntity>>>
  getBookings() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity()
        .checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      var either = await homeRemoteDataSource.getBookings();
      return either.fold((error) => Left(error), (response) {
        homeOfflineDataSource.saveBookingsOffline(
          bookingsResponseEntityList: response,
        );
        return Right(response);
      });
    } else {
      var either = await homeOfflineDataSource.getBookingsFromCache();
      return either.fold((error) => Left(error), (response) => Right(response));
    }
  }

  @override
  Future<Either<Failures, List<ServicesResponseEntity>>>
  getServicesFromCache() async {
    var either = await homeOfflineDataSource.getServicesFromCache();
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  void saveServicesOffline({
    required List<ServicesResponseEntity> servicesResponseEntityList,
  }) {
    homeOfflineDataSource.saveServicesOffline(
      servicesResponseEntityList: servicesResponseEntityList,
    );
  }

  @override
  Future<Either<Failures, List<BookingServiceResponseEntity>>>
  getBookingsFromCache() async {
    var either = await homeOfflineDataSource.getBookingsFromCache();
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  void saveBookingsOffline({
    required List<BookingServiceResponseEntity> bookingsResponseEntityList,
  }) {
    homeOfflineDataSource.saveBookingsOffline(
      bookingsResponseEntityList: bookingsResponseEntityList,
    );
  }
}
