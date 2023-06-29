import 'package:get/get.dart';
import 'package:learn_banking_finance/ui/faq/controller/faq_controller.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaqController>(
          () => FaqController(),
    );
  }
}
