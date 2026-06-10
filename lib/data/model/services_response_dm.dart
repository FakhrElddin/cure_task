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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = super.id;
    data['name'] = super.name;
    data['price'] = super.price;
    data['icon'] = super.icon;
    data['description'] = super.description;
    data['createdAt'] = super.createdAt;
    return data;
  }

}
