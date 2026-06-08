import 'package:cure_app/domain/entities/register_response_entity.dart';

class RegisterResponseDM extends RegisterResponseEntity{
  RegisterResponseDM({
      super.message,
      super.token,
      super.user,
  });

  RegisterResponseDM.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? UserDM.fromJson(json['user']) : null;
  }

}

class UserDM extends UserEntity {
  UserDM({
      super.id,
      super.name,
      super.email,
  });

  UserDM.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

}