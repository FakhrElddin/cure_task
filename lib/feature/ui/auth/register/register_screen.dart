import 'package:cure_app/core/di/di.dart';
import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/core/utils/app_routes.dart';
import 'package:cure_app/core/utils/app_styles.dart';
import 'package:cure_app/core/utils/app_validators.dart';
import 'package:cure_app/core/utils/dialog_utils.dart';
import 'package:cure_app/feature/ui/auth/register/cubit/register_cubit.dart';
import 'package:cure_app/feature/ui/auth/register/cubit/register_states.dart';
import 'package:cure_app/feature/ui/widgets/custom_text_button.dart';
import 'package:cure_app/feature/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    RegisterCubit viewModel = getIt<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Create New Account', style: AppStyles.bold26Text),
      ),
      body: BlocListener<RegisterCubit, RegisterStates>(
        bloc: viewModel,
        listener: (context, state) {
          if(state is RegisterLoadingState){
            DialogUtils.showLoading(context: context, message: 'Loading...');
          } else if (state is RegisterErrorState){
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(context: context, message: state.failure.errorMessage,posActionName: 'OK',title: 'ERROR');
          } else if(state is RegisterSuccessState){
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRoute, (route) => false,);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: SingleChildScrollView(
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  SizedBox(height: 37.h),
                  CustomTextFormField(
                    fieldName: 'Full Name',
                    hintText: 'Enter Your Full Name',
                    validator: AppValidators.validateFullName,
                    controller: viewModel.nameController,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    fieldName: 'Password',
                    hintText: 'Enter Your Password',
                    isPassword: true,
                    validator: AppValidators.validatePassword,
                    controller: viewModel.passwordController,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    fieldName: 'Email',
                    hintText: 'Enter Your Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.validateEmail,
                    controller: viewModel.emailController,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    fieldName: 'Mobile Number',
                    hintText: 'Enter Your Phone Number',
                    keyboardType: TextInputType.number,
                    validator: AppValidators.validatePhoneNumber,
                    controller: viewModel.phoneController,
                  ),
                  SizedBox(height: 63.h),
                  CustomTextButton(
                    text: 'Sign Up',
                    onPressed: () {
                      viewModel.register();
                    },
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'have an account? ', style: AppStyles.semiBold16Text),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),

                        child: Text(
                          'Sign In Now',
                          style: AppStyles.semiBold16Text.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
