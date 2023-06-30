import 'package:get/get.dart';

import '../controller/accounting_controller.dart';

class AccountingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountingController>(
          () => AccountingController(),
    );
  }
}
