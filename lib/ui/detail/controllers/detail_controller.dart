import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_banking_finance/datamodel/bank_data.dart';
import 'package:learn_banking_finance/main.dart';
import 'package:learn_banking_finance/utils/debug.dart';
import 'package:learn_banking_finance/utils/preference.dart';

import '../../../utils/constant.dart';

class DetailController extends GetxController {
  List<Accounting> bankData = [];
  List<FaqTips> tipsData = [];
  int mainIndex = 0;
  int subIndex = 0;
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
      tipsData.clear();
      bankData.clear();
      if(isTips){
        tipsData = Get.arguments[1];
        for(int i = 0; i < tipsData.length; i++){
          tipsData[i].isMark = false;
        }
      }else{
        if(Get.arguments[1] != null) {
          bankData = Get.arguments[1];
          for(int i = 0; i < bankData[0].detail![mainIndex].dataList!.length;i++){
            bankData[0].detail![mainIndex].dataList![i].isMark = false;
          }
        }
      }
      if (Get.arguments[2] != null) {
        mainIndex = Get.arguments[2];
        if(isTips) {
          pageController =
              PageController(
                  initialPage: mainIndex, keepPage: true, viewportFraction: 1);
        }
      }
      if(Get.arguments[3] != null){
        subIndex = Get.arguments[3];
        if(!isTips) {
          pageController =
              PageController(
                  initialPage: subIndex, keepPage: true, viewportFraction: 1);
        }
      }
    }

    getBookMarkData();
    /*if(isTips){
      checkMarkData(pageIndexValue: mainIndex);
    }else {
      checkMarkData(pageIndexValue: subIndex);
    }*/
    super.onInit();
  }

  getBookMarkData(){
    bookmarkCheckDataList.clear();
    if(Preference.shared.getString(Preference.bookMarkDetailData) != ""){
      var oldData = Preference.shared.getString(Preference.bookMarkDetailData);
      List<dynamic> rellyAStringList = jsonDecode(oldData.toString());
      for (Map bookMarkData in rellyAStringList) {
        Debug.printLog("book mark data screen.......${jsonEncode(bookMarkData)}");
        var bookData = FaqTips(title: bookMarkData["title"], desc: bookMarkData["desc"],image:  bookMarkData["image"]);
        bookmarkCheckDataList.add(bookData);
      }
    }

    if(isTips){
      checkMarkData(pageIndexValue: mainIndex);
    }else {
      checkMarkData(pageIndexValue: subIndex);
    }
  }

  void checkMarkData({int? pageIndexValue}){
    if(bookmarkCheckDataList.isNotEmpty){
      if(isTips){
        mainIndex = pageIndexValue!;
      }else{
        subIndex = pageIndexValue!;
      }
      for(int i=0;i < bookmarkCheckDataList.length;i++){
        if(isTips){
          var listDataIndex = tipsData.indexWhere((element) => element.title == bookmarkCheckDataList[i].title && element.desc == bookmarkCheckDataList[i].desc);
          if (listDataIndex != -1 && pageIndexValue == listDataIndex) {
            tipsData[mainIndex].isMark = true;
            Debug.printLog("index of bookmark data isTips ....$listDataIndex  $pageIndexValue");
            update([Constant.idAppBar]);
            break;
          }
        }else {
          var listDataIndex = bankData[0].detail![mainIndex].dataList!.indexWhere((element) => element.title == bookmarkCheckDataList[i].title && element.desc == bookmarkCheckDataList[i].desc);
          if (listDataIndex != -1 && pageIndexValue == listDataIndex) {
            bankData[0].detail![mainIndex].dataList![listDataIndex].isMark = true;
            Debug.printLog("index of bookmark data....$listDataIndex  $pageIndexValue");
            update([Constant.idAppBar]);
            break;
          }
        }
      }
    }
  }

  void addBookmarkData() {
    var pageViewIndex = pageController.page!.toInt();

    var title = "";
    var desc = "";
    var image = "";

    if(isTips) {
      title = tipsData[pageViewIndex].title.toString();
      desc = tipsData[pageViewIndex].desc.toString();
      image = tipsData[pageViewIndex].image.toString();
      tipsData[pageViewIndex].isMark = true;
      mainIndex = pageViewIndex;
    }else{
      title = bankData[0].detail![mainIndex].dataList![pageViewIndex].title.toString();
      desc = bankData[0].detail![mainIndex].dataList![pageViewIndex].desc.toString();
      image = "";
      bankData[0].detail![mainIndex].dataList![pageViewIndex].isMark = true;
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
    Debug.printLog("Bookmark......changedValuesForPage........");
    getBookMarkData();
    update([Constant.idAppBar]);
  }

  void changedValuesForPage(int value) {
    checkMarkData(pageIndexValue: value);
    update([Constant.idAppBar]);
  }

  void removeTipsBookMark() {
    getBookMarkData();
    if(bookmarkCheckDataList.isNotEmpty) {
      var pageViewIndex = pageController.page!.toInt();
      var addedDataIndex = bookmarkCheckDataList.indexWhere((element) =>
      element.title == tipsData[pageViewIndex].title.toString() &&
          element.desc == tipsData[pageViewIndex].desc.toString());
      bookmarkCheckDataList.removeAt(addedDataIndex);
      if(bookmarkCheckDataList.isNotEmpty) {
        Preference.shared.setString(
            Preference.bookMarkDetailData, jsonEncode(bookmarkCheckDataList));
      }else{
        Preference.shared.setString(
            Preference.bookMarkDetailData, "");
      }
      tipsData[pageViewIndex].isMark = false;
    }
    Debug.printLog("Bookmark......removeTipsBookMark........  ${bookmarkCheckDataList.length}");

    update([Constant.idAppBar]);
  }

  void removeBankDataBookMark() {
    getBookMarkData();
    if(bookmarkCheckDataList.isNotEmpty) {
      var pageViewIndex = pageController.page!.toInt();

      var addedDataIndex = bankData[0].detail![mainIndex]
          .dataList!.indexWhere((element) =>
      element.title == bankData[0].detail![mainIndex]
          .dataList![pageViewIndex].title.toString() &&
          element.desc == bankData[0].detail![mainIndex]
              .dataList![pageViewIndex].desc.toString());

      bankData[0].detail![mainIndex]
          .dataList![pageViewIndex].isMark = false;

      bookmarkCheckDataList.removeAt(addedDataIndex);
      if(bookmarkCheckDataList.isNotEmpty) {
        Preference.shared.setString(
            Preference.bookMarkDetailData, jsonEncode(bookmarkCheckDataList));
      }else{
        Preference.shared.setString(
            Preference.bookMarkDetailData, "");
      }

    }
    Debug.printLog("Bookmark......removeBankDataBookMark........  ${bookmarkCheckDataList.length}");

    update([Constant.idAppBar]);
  }

  void nextPrevPage(bool isNext) {
    getBookMarkData();
    if(isNext){
      pageController.nextPage(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn);
    }else{
      pageController.previousPage(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn);
    }
    update([Constant.idAppBar]);
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
