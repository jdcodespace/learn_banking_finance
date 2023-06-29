import 'package:get/get.dart';

class FaqController extends GetxController{

  bool isVisible = false;
 int selectedIndex = 0;
  dataVisible(int index){
    selectedIndex = index;
    isVisible = !isVisible ;
    update();
  }
}