import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:windy/features/auth/auth_controller.dart';
import 'package:windy/features/auth/login_page.dart';
import 'package:windy/features/components/loading.dart';
import 'package:windy/features/main/main_page.dart';
import 'package:windy/features/main/splash_page.dart';
import 'package:windy/features/services/user_service.dart';

import 'features/auth/register_page.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  Get.put<UserService>(UserService() ,permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   Loading(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: const [
          // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],
        initialRoute: "/",
        theme: ThemeData(
            colorScheme: ColorScheme.light(
                primary:Colors.blue
            )
        ),
        getPages: [
          GetPage(
            name: '/',
            page: () => SplashPage(),
          ),
          GetPage(
            name: '/login',
            page: () => LoginPage(),
          ),
          GetPage(
            name: "/register",
            page: () => RegisterPage(),
          ),
          GetPage(
            name: "/main",
            page: () => MainPage(),
          ),
        ],
      ),
    );
  }
}


