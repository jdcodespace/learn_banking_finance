import 'package:get/get.dart';

class DetailController extends GetxController {

  String title = "";
  dynamic arguments = Get.arguments;

  @override
  void onInit() {
    if(arguments != null){
      if(arguments[0] != null){
        title = arguments[0];
      }
    }
    super.onInit();
  }

}
