import 'package:get/get.dart';
import 'package:learn_banking_finance/utils/constant.dart';

import '../../../datamodel/bank_data.dart';

class ViewAllController extends GetxController {

  String title = "";
  dynamic arguments = Get.arguments;
  List<Accounting> blogData = [];

  @override
  void onInit() {
    if(arguments != null){
      if(arguments[0] != null){
        title = arguments[0];
      }
    }
    blogData = Constant.firebaseBankData.data!.bank!.where((element) =>element.title == "Blogs").toList();
    super.onInit();
  }

}
