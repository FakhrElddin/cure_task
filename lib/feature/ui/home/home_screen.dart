import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/feature/ui/home/cubit/home_cubit.dart';
import 'package:cure_app/feature/ui/home/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit viewModel = HomeCubit();
    return BlocBuilder<HomeCubit, HomeStates>(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedIconTheme: IconThemeData(
              size: 26,
              color: AppColors.blackColor,
            ),
            selectedIconTheme: IconThemeData(
              size: 28,
              color: Color(0xffD2EBE7),
            ),
            currentIndex: viewModel.currentIndex,
            items: [
              customBottomNavBarItem(icon: Icon(Icons.home_outlined)),
              customBottomNavBarItem(icon: Icon(Icons.access_time_outlined)),
              customBottomNavBarItem(icon: Icon(Icons.message_outlined)),
              customBottomNavBarItem(icon: Icon(Icons.account_circle_outlined)),
            ],
            onTap: (index) {
              viewModel.changeBottomNavBar(index: index);
            },
          ),
          body: viewModel.tabs[viewModel.currentIndex],
        );
      },
    );
  }
}

BottomNavigationBarItem customBottomNavBarItem({required Icon icon}) {
  return BottomNavigationBarItem(
    activeIcon: Container(
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: icon,
    ),
    icon: Container(
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.transparentColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: icon,
    ),
    label: '',
  );
}
