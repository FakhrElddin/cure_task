class RegisterResponseEntity {
  RegisterResponseEntity({
      this.message,
      this.token,
      this.user,
  });

  String? message;
  String? token;
  UserEntity? user;

}

class UserEntity {
  UserEntity({
      this.id,
      this.name,
      this.email,
  });

  String? id;
  String? name;
  String? email;

}