import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingsTab extends StatelessWidget {
  const BookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            SliverToBoxAdapter(
              child: Text('Your Bookings', style: AppStyles.semiBold24Text),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16.h)),
            SliverList.separated(
              itemBuilder: (context, index) => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28.r,
                    backgroundColor: AppColors.primaryColor,
                    child: Text('${index + 1}', style: AppStyles.bold22Text),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Service Name',
                          style: AppStyles.semiBold18Text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Clinical Remarks text goes here...',
                          style: AppStyles.semiBold16Text.copyWith(
                            color: AppColors.greyColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    children: [
                      Text('150 EGP', style: AppStyles.semiBold18Text),
                      SizedBox(height: 6.h),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 6.h,
                        ),
                        child: Text(
                          'pending',
                          style: AppStyles.semiBold16Text.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              separatorBuilder: (context, index) => Divider(
                height: 50,
                color: AppColors.greyColor.withValues(alpha: 0.4),
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
              itemCount: 10,
            ),
            SliverToBoxAdapter(child: SizedBox(height: 40.h)),
          ],
        ),
      ),
    );
  }
}
