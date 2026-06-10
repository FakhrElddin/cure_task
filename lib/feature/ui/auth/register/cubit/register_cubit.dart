import 'package:cure_app/domain/use_cases/register_use_case.dart';
import 'package:cure_app/feature/ui/auth/register/cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit({required this.registerUseCase}) : super(RegisterInitState());
  RegisterUseCase registerUseCase;
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void register() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      var either = await registerUseCase.invoke(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
      );
      either.fold(
        (failure) => emit(RegisterErrorState(failure: failure)),
        (response) =>
            emit(RegisterSuccessState(registerResponseEntity: response)),
      );
    }
  }
}
