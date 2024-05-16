import 'package:flutter/material.dart';
import 'package:game2/core/constants/routes.dart';
import 'package:game2/core/services/services.dart';
import 'package:get/get.dart';

class MyLoginMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;
  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("logged") == "1") {
      return const RouteSettings(name: AppRoute.home);
    }
  }
}
