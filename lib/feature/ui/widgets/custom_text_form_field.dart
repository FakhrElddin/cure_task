import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.fieldName,
    this.isPassword = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
  });

  final String fieldName;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.fieldName, style: AppStyles.semiBold22Text),
        SizedBox(height: 18.h),
        TextFormField(
          obscureText: widget.isPassword ? !obscureText : obscureText,
          obscuringCharacter: '*',
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          decoration: InputDecoration(
            fillColor: AppColors.greyColor.withValues(alpha: 0.3),
            filled: true,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: obscureText
                        ? Icon(
                            Icons.visibility,
                            color: AppColors.primaryColor,
                          )
                        : Icon(Icons.visibility_off, color: AppColors.primaryColor),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.greyColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.greyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
