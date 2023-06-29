import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/datamodel/bank_data.dart';

class DetailController extends GetxController {

  List<Accounting> blogData = [];
  int mainIndex = 0;
  int subIndex = 0;
  PageController pageController =
  PageController(initialPage: 0, keepPage: true, viewportFraction: 1);

  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments[0] != null){
        blogData = Get.arguments[0];
      }
      if(Get.arguments[1] != null){
        mainIndex = Get.arguments[1];
      }
      if(Get.arguments[2] != null){
        subIndex = Get.arguments[2];
      }

    }
    super.onInit();
  }

}
