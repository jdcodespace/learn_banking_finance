import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/datamodel/bank_data.dart';

class DetailController extends GetxController {
  List<Accounting> bankData = [];
  List<FaqTips> tipsData = [];
  int mainIndex = 0;
  bool isTips = false ;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments[0] != null) {
        isTips = Get.arguments[0];
      }
      if(isTips == true){
        tipsData = Get.arguments[1];
      }else{
        bankData = Get.arguments[1];
      }
      if (Get.arguments[2] != null) {
        mainIndex = Get.arguments[2];
      }
    }
    super.onInit();
  }
}
