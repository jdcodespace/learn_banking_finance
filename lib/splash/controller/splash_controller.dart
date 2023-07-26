import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';

class SplashController extends GetxController {
  void isLogin() {
    Timer(
      const Duration(seconds: 3),
      () => Get.offAllNamed(AppRoutes.home),
    );
  }

  @override
  Future<void> onInit() async {
    isLogin();
    super.onInit();
  }
}
