import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/initService.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {

    final storage = Get.find<InitServices>().sharedPreferences!;
    final token   = storage.getString('token');

    if (token != null && token.isNotEmpty) {
      return const RouteSettings(name: '/homePage');
    }
    return null;
  }
}