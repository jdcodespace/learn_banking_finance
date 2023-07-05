import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_banking_finance/utils/constant.dart';

import '../../../datamodel/bank_data.dart';

class SliderController extends GetxController{
  RxInt selectedIndex = 0.obs;
int totalIndex = 0;
  PageController pageController =
  PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
List<SliderData> sliderData = [];


  changeIndex(value) {
    selectedIndex.value = value;
    update();
  }
  @override
  void onInit() {

    sliderData = Constant.firebaseBankData.data!.slider!;
    super.onInit();
  }
}