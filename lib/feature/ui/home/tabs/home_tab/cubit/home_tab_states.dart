import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/services_response_entity.dart';

abstract class HomeTabStates {}

class HomeTabInitState extends HomeTabStates{}

class HomeTabLoadingState extends HomeTabStates{}

class HomeTabSuccessState extends HomeTabStates{
  final List<ServicesResponseEntity> servicesResponseEntity;

  HomeTabSuccessState({required this.servicesResponseEntity});
}

class HomeTabErrorState extends HomeTabStates{
  final Failures failure;

  HomeTabErrorState({required this.failure});
}