class LoginResponseEntity {
  LoginResponseEntity({
      this.token, 
      this.user,});

  String? token;
  UserEntity? user;

}

class UserEntity {
  UserEntity({
      this.id, 
      this.name, 
      this.email,});

  String? id;
  String? name;
  String? email;

}