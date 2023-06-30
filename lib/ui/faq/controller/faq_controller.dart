import 'package:get/get.dart';

import '../../../datamodel/bank_data.dart';
import '../../../utils/constant.dart';
import '../../home/views/home_screen.dart';

class FaqController extends GetxController{

  bool isVisible = false;
  dynamic argument = Get.arguments;
  List<FaqTips> faqData = [];
  String blogTitle = "";
  String learnTitle = "";
  CategoryFinanceClass? categoryFinanceClass;
 int selectedIndex = 0;
  dataVisible(int index){
    selectedIndex = index;
    isVisible = !isVisible ;
    update();
  }

  @override
  void onInit() {
    if(argument != null){
      if(argument[0] != null){
        categoryFinanceClass = argument[0];
      }
    }
    faqData = Constant.firebaseBankData.data!.faq!.toList();
    super.onInit();
  }
}