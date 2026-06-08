import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/feature/ui/home/tabs/home_tab/home_tab.dart';
import 'package:cure_app/feature/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:cure_app/feature/ui/home/tabs/second_tab/second_tab.dart';
import 'package:cure_app/feature/ui/home/tabs/third_tab/third_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [
    HomeTab(),
    SecondTab(),
    ThirdTab(),
    ProfileTab(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
        currentIndex: currentIndex,
        items: [
          customBottomNavBarItem(icon: Icon(Icons.home_outlined)),
          customBottomNavBarItem(icon: Icon(Icons.access_time_outlined)),
          customBottomNavBarItem(icon: Icon(Icons.message_outlined)),
          customBottomNavBarItem(icon: Icon(Icons.account_circle_outlined)),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: tabs[currentIndex],
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
