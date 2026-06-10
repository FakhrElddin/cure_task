import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/register_response_entity.dart';

abstract class RegisterStates {}

class RegisterInitState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final RegisterResponseEntity registerResponseEntity;

  RegisterSuccessState({required this.registerResponseEntity});
}

class RegisterErrorState extends RegisterStates{
  final Failures failure;

  RegisterErrorState({required this.failure});
}