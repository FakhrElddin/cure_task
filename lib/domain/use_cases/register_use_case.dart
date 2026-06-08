import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/entities/register_response_entity.dart';
import 'package:cure_app/domain/repositories/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<Either<Failures, RegisterResponseEntity>> invoke({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    return authRepository.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );
  }
}
