import 'package:get/get.dart';
import 'package:learn_banking_finance/utils/constant.dart';

import '../../../datamodel/bank_data.dart';

class ViewAllController extends GetxController {

  String title = "";
  dynamic arguments = Get.arguments;
  List<Accounting> bankData = [];

  @override
  void onInit() {
    if(arguments != null){
      if(arguments[0] != null){
        title = arguments[0];
      }
      if(arguments[1] != null){
        bankData = arguments[1];
      }
    }
    super.onInit();
  }

}
