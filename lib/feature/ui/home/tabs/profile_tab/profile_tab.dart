import 'package:cure_app/core/cache/shared_prefs_utils.dart';
import 'package:cure_app/core/utils/app_assets.dart';
import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/core/utils/app_constants.dart';
import 'package:cure_app/core/utils/app_routes.dart';
import 'package:cure_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  final List<BuildProfileItem> profileItems = const [
    BuildProfileItem(icon: Icons.settings_outlined, title: 'Profile Settings'),
    BuildProfileItem(
      icon: Icons.location_on_outlined,
      title: 'Saved Addresses',
    ),
    BuildProfileItem(icon: Icons.payment_outlined, title: 'Payment Methods'),
    BuildProfileItem(icon: Icons.help_outline, title: 'Help & Support'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: AssetImage(AppAssets.userImage),
                  ),
                  SizedBox(height: 16.h),
                  Text('Pankaj Sharma', style: AppStyles.semiBold24Text),
                  SizedBox(height: 8.h),
                  Text(
                    'pankajsharma@gmail.com',
                    style: AppStyles.semiBold16Text,
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
            SliverList.separated(
              itemCount: profileItems.length,
              itemBuilder: (context, index) => profileItems[index],
              separatorBuilder: (context, index) => SizedBox(height: 24.h),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 40.h)),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  SharedPrefsUtils.removeData(key: AppConstants.userToken);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.loginRoute,
                    (route) => false,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red.withValues(alpha: 0.5),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout, color: AppColors.redColor),
                      SizedBox(width: 8.w),
                      Text(
                        'Logout',
                        style: AppStyles.semiBold18Text.copyWith(
                          color: AppColors.redColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildProfileItem extends StatelessWidget {
  const BuildProfileItem({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.greyColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 24.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: AppStyles.semiBold16Text.copyWith(
                color: AppColors.blackColor,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.greyColor,
            size: 18.sp,
          ),
        ],
      ),
    );
  }
}
