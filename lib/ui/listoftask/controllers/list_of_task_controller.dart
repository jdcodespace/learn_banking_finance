import 'package:get/get.dart';

import '../../../datamodel/bank_data.dart';

class ListOfTaskController extends GetxController {

  String title = "";
  List<Accounting> blogData = [];
  int mainIndex = 0;

  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments[0] != null){
        blogData = Get.arguments[0];
        title = Get.arguments[1];
        mainIndex = Get.arguments[2];
      }
    }
    super.onInit();
  }



}
