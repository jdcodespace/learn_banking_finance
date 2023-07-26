import 'package:get/get.dart';
import 'package:learn_banking_finance/splash/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
          () => SplashController(),
    );
  }
}
