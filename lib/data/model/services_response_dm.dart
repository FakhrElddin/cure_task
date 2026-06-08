import 'package:cure_app/domain/entities/services_response_entity.dart';

class ServicesResponseDM extends ServicesResponseEntity {
  ServicesResponseDM({
    super.id,
    super.name,
    super.price,
    super.icon,
    super.createdAt,
    super.description,
  });

  ServicesResponseDM.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    icon = json['icon'];
    createdAt = json['createdAt'];
    description = json['description'];
  }
}
