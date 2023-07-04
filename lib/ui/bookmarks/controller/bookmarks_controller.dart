import 'dart:convert';

import 'package:get/get.dart';
import 'package:learn_banking_finance/utils/preference.dart';

import '../../../datamodel/bank_data.dart';
import '../../../utils/debug.dart';
import '../../detail/controllers/detail_controller.dart';


class BookMarkController extends GetxController{

  // List<BookMarkDataClass> listData = [];
  List<FaqTips> listData = [];

  @override
  void onInit() {
    getBookMarkData();
    super.onInit();
  }

  getBookMarkData(){
    listData.clear();
    if(Preference.shared.getString(Preference.bookMarkDetailData) != ""){
      var oldData = Preference.shared.getString(Preference.bookMarkDetailData);
      List<dynamic> rellyAStringList = jsonDecode(oldData.toString());
      for (Map bookMarkData in rellyAStringList) {
        Debug.printLog("book mark data screen.......${jsonEncode(bookMarkData)}");
        var bookData = FaqTips(title: bookMarkData["title"], desc: bookMarkData["desc"],image:  bookMarkData["image"]);
        listData.add(bookData);
      }
    }
    update();
  }

}