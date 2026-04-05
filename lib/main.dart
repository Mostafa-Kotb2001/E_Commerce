import 'package:E_Commerce/services/initService.dart';
import 'package:E_Commerce/controllers/confirm_controller.dart';
import 'package:E_Commerce/screens/confirmation_page.dart';
import 'package:E_Commerce/screens/home.dart';
import 'package:E_Commerce/screens/home_page.dart';
import 'package:E_Commerce/screens/login.dart';
import 'package:E_Commerce/screens/signUp.dart';
import 'package:E_Commerce/services/initService.dart';

import '';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'middelwares/AuthMiddleware.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

Future init () async {
  await Get.putAsync( () async => InitServices().init());
  Get.put(AuthController(), permanent: true);
  Get.put(ConfirmationController(), permanent: true);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner : false ,
      initialRoute: '/login',
      getPages: [
        GetPage(name: "/login", page: () => Login() , middlewares: [AuthMiddleware()]),
        GetPage(name: '/home', page: () => Home()),
        GetPage(name: '/signUp', page: () => SignUp()),
        GetPage(name: '/homePage', page: () => HomePage()),
        GetPage(name: '/confirmation', page: () => ConfirmationPage()),

      ],
    );
  }
}

























