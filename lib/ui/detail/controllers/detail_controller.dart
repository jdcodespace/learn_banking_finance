import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_banking_finance/datamodel/bank_data.dart';
import 'package:learn_banking_finance/main.dart';
import 'package:learn_banking_finance/utils/debug.dart';
import 'package:learn_banking_finance/utils/preference.dart';

class DetailController extends GetxController {
  List<Accounting> bankData = [];
  List<FaqTips> tipsData = [];
  int mainIndex = 0;
  bool isTips = false ;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  List<FaqTips> bookmarkCheckDataList = [];
  bool isBookMark = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments[0] != null) {
        isTips = Get.arguments[0];
      }
      if(isTips){
        tipsData = Get.arguments[1];
      }else{
        if(Get.arguments[1] != null) {
          bankData = Get.arguments[1];
        }
      }
      if (Get.arguments[2] != null) {
        mainIndex = Get.arguments[2];
        pageController =
            PageController(initialPage: mainIndex, keepPage: true, viewportFraction: 1);
      }
    }


   /* if(Preference.shared.getString(Preference.bookMarkDetailData) != ""){
      var oldData = Preference.shared.getString(Preference.bookMarkDetailData);
      List<dynamic> rellyAStringList = jsonDecode(oldData.toString());
      for (Map bookMarkData in rellyAStringList) {
        Debug.printLog("book mark data screen.......${jsonEncode(bookMarkData)}");
        var bookData = FaqTips(title: bookMarkData["title"], desc: bookMarkData["desc"],image:  bookMarkData["image"]);
        bookmarkCheckDataList.add(bookData);
      }
    }


    if(bookmarkCheckDataList.isNotEmpty){
      var title = (isTips == true)
          ? tipsData[mainIndex].title.toString()
          : bankData[0].detail![mainIndex]
          .dataList![0].title
          .toString();
      var listData = bookmarkCheckDataList.where((element) => element.title = )
    }*/

    super.onInit();
  }

  void addBookmarkData() {
    var pageViewIndex = pageController.initialPage;

    var title = "";
    var desc = "";
    var image = "";

    if(isTips) {
      title = tipsData[pageViewIndex].title.toString();
      desc = tipsData[pageViewIndex].desc.toString();
      image = tipsData[pageViewIndex].image.toString();
    }else{
      title = bankData[0].detail![mainIndex].dataList![pageViewIndex].title.toString();
      desc = bankData[0].detail![mainIndex].dataList![pageViewIndex].desc.toString();
      image = "";
    }
    var bookMarkData = BookMarkDataClass(title, desc, image);
    var stringOldDatList = [];

    if(Preference.shared.getString(Preference.bookMarkDetailData) != ""){
      var oldData = Preference.shared.getString(Preference.bookMarkDetailData);
      List<dynamic> rellyAStringList = jsonDecode(oldData.toString());
      for (Map bookMarkData in rellyAStringList) {
        Debug.printLog("book mark data.......${jsonEncode(bookMarkData)}");
        stringOldDatList.add(json.encode(bookMarkData));
      }
    }
    stringOldDatList.add(json.encode(bookMarkData));
    Preference.shared.setString(Preference.bookMarkDetailData, stringOldDatList.toString());

    Debug.printLog("Bookmark data..........${Preference.shared.getString(Preference.bookMarkDetailData)}");
  }

  void onChangedPageValue(bool isNext) {
    if(isNext) {
      mainIndex++;
    }else{
      mainIndex--;
    }
    pageController.animateToPage(mainIndex, duration: Duration(milliseconds: 50), curve: Curves.easeIn);
    update();
  }
}

class BookMarkDataClass{
  String title = "";
  String desc = "";
  String image = "";

  BookMarkDataClass(this.title,this.desc,this.image);

  BookMarkDataClass.fromJson(Map json) {
    title = json['title'];
    desc = json['desc'];
    image = json['image'];
  }

  Map toJson() {
    final Map data = {};
    data['title'] = title;
    data['desc'] = desc;
    data['image'] = image;
    return data;
  }
}
