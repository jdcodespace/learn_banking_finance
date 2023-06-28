import 'package:get/get.dart';

class ListOfTaskController extends GetxController {

  String title = "What to do?";
  dynamic arguments = Get.arguments;

  @override
  void onInit() {
    /*if(arguments != null){
      if(arguments[0] != null){
        title = arguments[0];
      }
    }*/
    super.onInit();
  }



}
