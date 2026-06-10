import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/login_response_entity.dart';

abstract class LoginStates {}

class LoginInitState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final LoginResponseEntity loginResponseEntity;

  LoginSuccessState({required this.loginResponseEntity});
}

class LoginErrorState extends LoginStates{
  final Failures failure;

  LoginErrorState({required this.failure});
}