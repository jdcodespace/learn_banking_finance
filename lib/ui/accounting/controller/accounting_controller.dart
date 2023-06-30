import 'package:get/get.dart';

import '../../../datamodel/bank_data.dart';
import '../../../utils/constant.dart';
import '../../home/views/home_screen.dart';

class AccountingController extends GetxController {
  dynamic argument = Get.arguments;
  List<Accounting> blogData = [];
  List<Accounting> introductionData = [];
  List<Accounting> accountingData = [];
  List<Accounting> evolutionData = [];
  List<Accounting> advancedTopicData = [];
  String blogTitle = "";
  String learnTitle = "";
  CategoryFinanceClass? categoryFinanceClass;

  @override
  void onInit() {
    if (argument != null) {
      if (argument[0] != null) {
        categoryFinanceClass = argument[0];
      }
    }
    blogData = Constant.firebaseBankData.data!.accounting!
        .where((element) => element.title == "Blogs")
        .toList();
    introductionData = Constant.firebaseBankData.data!.accounting!
        .where((element) => element.title == "Introduction")
        .toList();
    accountingData = Constant.firebaseBankData.data!.accounting!
        .where((element) => element.title == "Accounting Basics")
        .toList();
    evolutionData = Constant.firebaseBankData.data!.accounting!
        .where((element) => element.title == "Evolution of Accounting")
        .toList();
    advancedTopicData = Constant.firebaseBankData.data!.accounting!
        .where((element) => element.title == "Advanced Topics")
        .toList();
    for (var i = 0; i < blogData[0].detail!.length; i++) {
      blogTitle = blogData[0].detail![i].title.toString();
      break;
    }

    super.onInit();
  }
}
