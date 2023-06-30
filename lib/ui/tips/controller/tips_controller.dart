import 'package:get/get.dart';

import '../../../datamodel/bank_data.dart';
import '../../../utils/constant.dart';
import '../../home/views/home_screen.dart';

class TipsController extends GetxController{
  bool isVisible = false;
  dynamic argument = Get.arguments;
  List<FaqTips> tipsData = [];

  CategoryFinanceClass? categoryFinanceClass;
  int selectedIndex = 0;


  @override
  void onInit() {
    if(argument != null){

      if(argument[0] != null){
        categoryFinanceClass = argument[0];
      }
    }
    tipsData = Constant.firebaseBankData.data!.tips!.toList();
    super.onInit();
  }
}