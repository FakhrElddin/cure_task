import 'package:cure_app/core/di/di.dart';
import 'package:cure_app/core/utils/app_assets.dart';
import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/core/utils/app_routes.dart';
import 'package:cure_app/core/utils/app_styles.dart';
import 'package:cure_app/feature/ui/home/tabs/home_tab/cubit/home_tab_cubit.dart';
import 'package:cure_app/feature/ui/home/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:cure_app/feature/ui/widgets/custom_app_bar.dart';
import 'package:cure_app/feature/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  final List<String> categories = const [
    'Nursing',
    'Elderly Care',
    'Physiotherapy',
    'Wound Care',
  ];
  HomeTabCubit viewModel = getIt<HomeTabCubit>()..getServices();
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeTabCubit, HomeTabStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is HomeTabErrorState) {
          return Center(
            child: Text(
              state.failure.errorMessage,
              style: AppStyles.semiBold18Text,
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is HomeTabSuccessState) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        CustomAppBar(),
                        CustomTextFormField(
                          fieldName: '',
                          hintText: 'Search medical services...',
                          fillColor: AppColors.greyColor.withValues(alpha: 0.2),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 24.0.h, right: 8.h),
                            child: Icon(
                              Icons.search,
                              color: AppColors.greyColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        CustomImageSlideShow(),
                        SizedBox(height: 18.h),
                        Text('Categories', style: AppStyles.semiBold24Text),
                        SizedBox(height: 30.h),
                        SizedBox(
                          height: 80.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              height: 80.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  categories[index],
                                  style: AppStyles.semiBold20Text,
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 15),
                            itemCount: categories.length,
                          ),
                        ),
                        SizedBox(height: 34.h),
                        Text(
                          'Popular Services',
                          style: AppStyles.semiBold24Text,
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                  SliverList.separated(
                    itemCount: state.servicesResponseEntity.length,
                    itemBuilder: (context, index) => Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.asset(
                            height: 162.h,
                            width: double.infinity,
                            AppAssets.servicesImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 26.h,
                          left: 177.w,
                          right: 16.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.servicesResponseEntity[index].name!,
                                style: AppStyles.semiBold18Text,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                state
                                    .servicesResponseEntity[index]
                                    .description!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.regular12Text.copyWith(
                                  color: AppColors.greyColor,
                                ),
                              ),
                              SizedBox(height: 14.h),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.serviceDetailsRoute,
                                    arguments:
                                        state.servicesResponseEntity[index],
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 6.h,
                                    horizontal: 22.5,
                                  ),
                                ),
                                child: Text(
                                  'Book for ${state.servicesResponseEntity[index].price} EGP',
                                  style: AppStyles.regular16Text,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 24),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 40.h)),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
      },
    );
  }
}

class CustomImageSlideShow extends StatelessWidget {
  const CustomImageSlideShow({super.key});

  final List<String> slideShowImages = const [
    AppAssets.slideShowImage,
    AppAssets.slideShowImage,
    AppAssets.slideShowImage,
    AppAssets.slideShowImage,
  ];

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      height: 200.h,
      width: double.infinity,
      initialPage: 0,
      autoPlayInterval: 3000,
      indicatorColor: AppColors.primaryColor,
      indicatorBackgroundColor: Color(0xffC4C4C4),
      indicatorRadius: 6,
      indicatorBottomPadding: 0,
      isLoop: true,
      indicatorPadding: 7.w,
      children: slideShowImages.map((image) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                width: double.infinity,
                height: 180.h,
                image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17.0, top: 23),
              child: Column(
                children: [
                  Text(
                    'Medical Center',
                    style: AppStyles.bold26Text.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 11),
                  Text(
                    'Jorem ipsum dolor, consectetur \nadipiscing elit. Nunc v libero et',
                    style: AppStyles.regular12Text,
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
