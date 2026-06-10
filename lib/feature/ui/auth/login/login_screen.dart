import 'package:cure_app/core/di/di.dart';
import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/core/utils/app_routes.dart';
import 'package:cure_app/core/utils/app_styles.dart';
import 'package:cure_app/core/utils/app_validators.dart';
import 'package:cure_app/core/utils/dialog_utils.dart';
import 'package:cure_app/feature/ui/auth/login/cubit/login_cubit.dart';
import 'package:cure_app/feature/ui/auth/login/cubit/login_states.dart';
import 'package:cure_app/feature/ui/widgets/custom_text_button.dart';
import 'package:cure_app/feature/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit viewModel = getIt<LoginCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome', style: AppStyles.bold26Text),
      ),
      body: BlocListener<LoginCubit, LoginStates>(
        bloc: viewModel,
        listener: (context, state) {
          if(state is LoginLoadingState){
            DialogUtils.showLoading(context: context, message: 'Loading...');
          } else if (state is LoginErrorState){
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(context: context, message: state.failure.errorMessage,posActionName: 'OK',title: 'ERROR');
          } else if(state is LoginSuccessState){
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRoute, (route) => false);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 42.h),
                  Text(
                    'Sign In',
                    style: AppStyles.bold26Text.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    'Korem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: AppStyles.regular18Text,
                  ),
                  SizedBox(height: 62.h),
                  CustomTextFormField(
                    fieldName: 'Email',
                    hintText: 'Enter Your Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.validateEmail,
                    controller: viewModel.emailController,
                  ),
                  SizedBox(height: 26.h),
                  CustomTextFormField(
                    fieldName: 'Password',
                    hintText: 'Enter Your Password',
                    isPassword: true,
                    validator: AppValidators.validateFullName,
                    controller: viewModel.passwordController,
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: InkWell(
                      onTap: () {
                        showForgetPasswordBottomSheet(context);
                      },
                      child: Text(
                        'Forget Password',
                        style: AppStyles.semiBold18Text,
                      ),
                    ),
                  ),
                  SizedBox(height: 75.h),
                  CustomTextButton(
                    text: 'Sign In',
                    onPressed: () {
                      viewModel.login();
                    },
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account? ',
                        style: AppStyles.semiBold16Text,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.registerRoute);
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text(
                          'Sign Up',
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

  void showForgetPasswordBottomSheet(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0.h),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    color: AppColors.greyColor.withValues(alpha: 0.7),
                    thickness: 6,
                    endIndent: 140,
                    indent: 140,
                    radius: BorderRadius.circular(6.r),
                    height: 40,
                  ),
                  SizedBox(height: 35.h),
                  Text('Forgot password', style: AppStyles.semiBold24Text),
                  SizedBox(height: 12.h),
                  Text(
                    'Enter your email for the verification proccesss,\nwe will send 4 digits code to your email.',
                    style: AppStyles.regular14Text,
                  ),
                  SizedBox(height: 36.h),
                  CustomTextFormField(
                    fieldName: 'Email',
                    hintText: 'Enter Your Email',
                    fillColor: AppColors.whiteColor,
                    validator: AppValidators.validateEmail,
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomTextButton(
                      text: 'Continue',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pop(context);
                          showCodeBottomSheet(context);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
    );
  }
}

void showCodeBottomSheet(BuildContext context) {
  GlobalKey<FormState> formKey = GlobalKey();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) =>
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: AppColors.greyColor.withValues(alpha: 0.7),
                  thickness: 6,
                  endIndent: 140,
                  indent: 140,
                  radius: BorderRadius.circular(6.r),
                  height: 40,
                ),
                SizedBox(height: 35.h),
                Text('Enter 4 Digits Code', style: AppStyles.semiBold24Text),
                SizedBox(height: 12.h),
                Text(
                  'Enter the 4 digits code that you received on\nyour email.',
                  style: AppStyles.regular14Text,
                ),
                SizedBox(height: 36.h),
                CustomTextFormField(
                  fieldName: 'Code',
                  hintText: 'Enter Code',
                  fillColor: AppColors.whiteColor,
                  validator: AppValidators.validateFullName,
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextButton(
                    text: 'Continue',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pop(context);
                        showResetBottomSheet(context);
                      }
                    },
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
  );
}

void showResetBottomSheet(BuildContext context) {
  GlobalKey<FormState> formKey = GlobalKey();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) =>
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: AppColors.greyColor.withValues(alpha: 0.7),
                  thickness: 6,
                  endIndent: 140,
                  indent: 140,
                  radius: BorderRadius.circular(6.r),
                  height: 40,
                ),
                SizedBox(height: 35.h),
                Text('Reset Password', style: AppStyles.semiBold24Text),
                SizedBox(height: 12.h),
                Text(
                  'Set the new password for your account so you can login and access all the features.',
                  style: AppStyles.regular14Text,
                ),
                SizedBox(height: 36.h),
                CustomTextFormField(
                  fieldName: 'New Password',
                  hintText: 'Enter New Password',
                  fillColor: AppColors.whiteColor,
                  validator: AppValidators.validatePassword,
                ),
                SizedBox(height: 18.h),
                CustomTextFormField(
                  fieldName: 'Confirm Password',
                  hintText: 'Re-enter Password',
                  fillColor: AppColors.whiteColor,
                  validator: AppValidators.validatePassword,
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextButton(
                    text: 'Update Password',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {

                      }
                    },
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
  );
}
