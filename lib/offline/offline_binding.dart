import 'package:get/get.dart';
import 'package:learn_banking_finance/offline/offline_controller.dart';


class OfflineBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OfflineController>(
      () => OfflineController(),
    );
  }
}
