import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/data/model/services_response_dm.dart';
import 'package:cure_app/domain/entities/services_response_entity.dart';
import 'package:cure_app/domain/repositories/data_sources/offline_data_sources/home_offline_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeOfflineDataSource)
class HomeOfflineDataSourceImpl implements HomeOfflineDataSource {
  @override
  Future<Either<Failures, List<ServicesResponseDM>>>
  getServicesFromCache() async{
    var box = await Hive.openBox('services');
    List<dynamic>? cachedData = box.get('servicesList');
    if(cachedData != null){
      List<ServicesResponseDM> servicesList = cachedData.map((service) {
        return ServicesResponseDM.fromJson(service);
      }).toList();

      return Right(servicesList);
    } else {
      return Left(NetworkError(errorMessage: 'No Internet Connection and No Cached Data'));
    }
  }

  @override
  void saveServicesOffline({
    required List<ServicesResponseEntity> servicesResponseEntityList,
  }) async{
    var box = await Hive.openBox('services');
    List<Map<String, dynamic>> mapsList = servicesResponseEntityList.map((entity) {
      return ServicesResponseDM(
        id: entity.id,
        name: entity.name,
        price: entity.price,
        icon: entity.icon,
        createdAt: entity.createdAt,
        description: entity.description,
      ).toJson();
    }).toList();
    await box.put('servicesList', mapsList);
    await box.close();
  }
}
