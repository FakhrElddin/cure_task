import 'package:cure_app/core/utils/app_routes.dart';
import 'package:cure_app/feature/ui/auth/login/login_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(CureApp());
}

class CureApp extends StatelessWidget {
  const CureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.loginRoute : (context) => LoginScreen(),
      },
      initialRoute: AppRoutes.loginRoute,
    );
  }
}
