import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/core/utils/app_routes.dart';
import 'package:cure_app/core/utils/app_styles.dart';
import 'package:cure_app/core/utils/app_validators.dart';
import 'package:cure_app/feature/ui/widgets/custom_text_button.dart';
import 'package:cure_app/feature/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome', style: AppStyles.bold26Text),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.validateEmail,
                ),
                SizedBox(height: 26.h),
                CustomTextFormField(
                  fieldName: 'Password',
                  isPassword: true,
                  validator: AppValidators.validatePassword,
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    'Forget Password',
                    style: AppStyles.semiBold18Text,
                  ),
                ),
                SizedBox(height: 75.h),
                CustomTextButton(
                  text: 'Sign In',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
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
    );
  }
}
