import 'package:get/get.dart';
import '../controllers/list_of_task_controller.dart';

class ListOfTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListOfTaskController>(
          () => ListOfTaskController(),
    );
  }
}
