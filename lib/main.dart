import 'package:bloc/bloc.dart';
import 'package:cure_app/core/cache/shared_prefs_utils.dart';
import 'package:cure_app/core/di/di.dart';
import 'package:cure_app/core/my_bloc_observer/my_bloc_observer.dart';
import 'package:cure_app/core/utils/app_constants.dart';
import 'package:cure_app/core/utils/app_routes.dart';
import 'package:cure_app/feature/ui/auth/login/login_screen.dart';
import 'package:cure_app/feature/ui/auth/register/register_screen.dart';
import 'package:cure_app/feature/ui/home/home_screen.dart';
import 'package:cure_app/feature/ui/service_details/service_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await SharedPrefsUtils.init();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  var token = SharedPrefsUtils.getData(key: AppConstants.userToken);
  runApp(CureApp(isTokenSaved: token != null ? true : false));
}

class CureApp extends StatelessWidget {
  const CureApp({super.key, required this.isTokenSaved});

  final bool isTokenSaved;

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
            AppRoutes.serviceDetailsRoute: (context) => ServiceDetailsScreen(),
          },
          initialRoute: isTokenSaved
              ? AppRoutes.homeRoute
              : AppRoutes.loginRoute,
        );
      },
    );
  }
}
