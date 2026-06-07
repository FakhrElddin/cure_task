import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/core/utils/app_styles.dart';
import 'package:cure_app/core/utils/app_validators.dart';
import 'package:cure_app/feature/ui/widgets/custom_text_button.dart';
import 'package:cure_app/feature/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Create New Account', style: AppStyles.bold26Text),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 37.h),
                CustomTextFormField(
                  fieldName: 'Full Name',
                  validator: AppValidators.validateFullName,
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  fieldName: 'Password',
                  validator: AppValidators.validatePassword,
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  fieldName: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.validateEmail,
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  fieldName: 'Mobile Number',
                  keyboardType: TextInputType.number,
                  validator: AppValidators.validatePhoneNumber,
                ),
                SizedBox(height: 63.h),
                CustomTextButton(
                  text: 'Sign Up',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                ),
                SizedBox(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('have an account? ', style: AppStyles.semiBold16Text),
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
    );
  }
}
