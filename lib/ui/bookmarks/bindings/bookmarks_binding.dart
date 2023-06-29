import 'package:get/get.dart';
import 'package:learn_banking_finance/ui/bookmarks/controller/bookmarks_controller.dart';

class BookMarksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookMarkController>(
          () => BookMarkController(),
    );
  }
}
