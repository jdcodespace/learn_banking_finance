import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/color.dart';
import '../../../utils/sizer_utils.dart';
import '../../home/views/home_screen.dart';
import '../views/banking_screen.dart';

class BankingController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic argument = Get.arguments;
  CategoryFinanceClass? categoryFinanceClass;

  @override
  void onInit() {

    /*Get arguments*/
    if(argument != null){
      if(argument[0] != null){
        categoryFinanceClass = argument[0];
      }
    }
    super.onInit();
  }
}
