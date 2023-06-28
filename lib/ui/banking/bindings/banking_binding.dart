import 'package:get/get.dart';
import '../controllers/banking_controller.dart';

class BankingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankingController>(
          () => BankingController(),
    );
  }
}
