import 'package:cure_app/core/utils/app_assets.dart';
import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/core/utils/app_styles.dart';
import 'package:cure_app/feature/ui/widgets/custom_app_bar.dart';
import 'package:cure_app/feature/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            CustomAppBar(),
            CustomTextFormField(
              fieldName: '',
              hintText: 'Search medical services...',
              fillColor: AppColors.greyColor.withValues(alpha: 0.2),
              prefixIcon: Padding(
                padding:  EdgeInsets.only(
                    left: 24.0.h,
                    right: 8.h,
                ),
                child: Icon(
                  Icons.search,
                  color: AppColors.greyColor,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
