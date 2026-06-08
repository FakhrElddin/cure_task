import 'package:cure_app/domain/entities/login_response_entity.dart';

class LoginResponseDM extends LoginResponseEntity{
  LoginResponseDM({
      super.token,
      super.user,
  });

  LoginResponseDM.fromJson(dynamic json) {
    token = json['token'];
    user = json['user'] != null ? UserDM.fromJson(json['user']) : null;
  }

}

class UserDM extends UserEntity{
  UserDM({
      super.id,
      super.name,
      super.email,});

  UserDM.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

}