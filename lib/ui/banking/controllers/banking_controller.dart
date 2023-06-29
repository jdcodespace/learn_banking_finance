import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/utils/constant.dart';
import '../../../datamodel/bank_data.dart';
import '../../home/views/home_screen.dart';

class BankingController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic argument = Get.arguments;
  CategoryFinanceClass? categoryFinanceClass;
  String title = "";
  List<Accounting> blogData = [];
  List<Accounting> learnBankingData = [];

  @override
  void onInit() {

    /*Get arguments*/
    if(argument != null){
      if(argument[0] != null){
        categoryFinanceClass = argument[0];
      }
    }
    blogData = Constant.firebaseBankData.data!.bank!.where((element) =>element.title == "Blogs").toList();
    learnBankingData = Constant.firebaseBankData.data!.bank!.where((element) =>element.title == "LearnBanking").toList();
    for(var i = 0 ; i <  blogData[0].detail!.length ; i++ ){
      title = blogData[0].detail![i].title.toString();
      break;
    }
    super.onInit();
  }
}
