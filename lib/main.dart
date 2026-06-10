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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  print('foreground message received: ${message.messageId}');
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupFlutterNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await SharedPrefsUtils.init();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  var token = SharedPrefsUtils.getData(key: AppConstants.userToken);
  String? deviceToken = await FirebaseMessaging.instance.getToken();
  print('device token is = $deviceToken');
  await requestNotificationPermission();
  runApp(CureApp(isTokenSaved: token != null ? true : false));
}

class CureApp extends StatefulWidget {
  const CureApp({super.key, required this.isTokenSaved});

  final bool isTokenSaved;

  @override
  State<CureApp> createState() => _CureAppState();
}

class _CureAppState extends State<CureApp> {

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

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
          initialRoute: widget.isTokenSaved
              ? AppRoutes.homeRoute
              : AppRoutes.loginRoute,
        );
      },
    );
  }
}

Future<void> requestNotificationPermission() async{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // request permission for ios
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    providesAppNotificationSettings: false,
    provisional: false,
    sound: true,
  );

  if(settings.authorizationStatus == AuthorizationStatus.authorized){
    print('user granted permission for notification');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional){
    print('user granted provisional notification');
  } else {
    print('user denied notification');
  }

  if(defaultTargetPlatform == TargetPlatform.android){
    if(await Permission.notification.isDenied){
      await Permission.notification.request();
    }
  }

}
