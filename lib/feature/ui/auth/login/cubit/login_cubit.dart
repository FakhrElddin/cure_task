import 'package:cure_app/domain/use_cases/login_use_case.dart';
import 'package:cure_app/feature/ui/auth/login/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit({required this.loginUseCase}) : super(LoginInitState());
  LoginUseCase loginUseCase;
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController(
    text: 'conas@nuitx.com',
  );
  TextEditingController passwordController = TextEditingController(
    text: 'Ahmed@123',
  );

  void login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      var either = await loginUseCase.invoke(
        email: emailController.text,
        password: passwordController.text,
      );
      either.fold(
        (failure) => emit(LoginErrorState(failure: failure)),
        (response) => emit(LoginSuccessState(loginResponseEntity: response)),
      );
    }
  }
}
