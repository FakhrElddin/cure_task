import 'package:cure_app/core/utils/app_routes.dart';
import 'package:cure_app/feature/ui/auth/login/login_screen.dart';
import 'package:cure_app/feature/ui/auth/register/register_screen.dart';
import 'package:cure_app/feature/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(CureApp());
}

class CureApp extends StatelessWidget {
  const CureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            AppRoutes.loginRoute: (context) => LoginScreen(),
            AppRoutes.registerRoute: (context) => RegisterScreen(),
            AppRoutes.homeRoute: (context) => HomeScreen(),
          },
          initialRoute: AppRoutes.loginRoute,
        );
      },
    );
  }
}
