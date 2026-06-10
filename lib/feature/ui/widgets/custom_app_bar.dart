import 'package:cure_app/core/utils/app_assets.dart';
import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 35.r,
          backgroundImage: AssetImage(
            AppAssets.userImage,
          ),
        ),
        SizedBox(
          width: 10.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi,Welcome Back,',
              style: AppStyles.regular14Text.copyWith(
                color: AppColors.greyColor,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Pankaj Sharma',
              style: AppStyles.semiBold18Text,
            ),
          ],
        ),
        Spacer(),
        IconButton(
          onPressed: (){},
          icon: Stack(
            children: [
              Icon(
                Icons.notifications_none_rounded,
                size: 34,
              ),
              Positioned(
                top: 2,
                right: 8,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: AppColors.redColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
