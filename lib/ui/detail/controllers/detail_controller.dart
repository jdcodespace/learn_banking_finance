import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/datamodel/bank_data.dart';
import '../../../google_ads/native/native_small_page_list_data.dart';
import '../../../utils/constant.dart';
import '../../../utils/debug.dart';
import '../../../utils/network_connectivity.dart';
import '../../../utils/preference.dart';
import '../../../utils/utils.dart';

class DetailController extends GetxController {
  List<Accounting> bankData = [];
  List<FaqTips> tipsData = [];
  int mainIndex = 0;
  int subIndex = 0;
  bool isTips = false;

  PageController pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  List<FaqTips> bookmarkCheckDataList = [];
  bool isBookMark = false;
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  bool isLoaded = true;

  onChangeNativeBannerAd(bool value){
    isLoaded = value;
    update();
    Debug.printLog("onChangeNativeBannerAd.....$value  $isLoaded");
  }

  @override
  void onInit() {
    networkConnectivity.initialise();
    networkConnectivity.myStream.listen((source) {
      source = source;
      // 1.
      switch (source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string = source.values.toList()[0] ? 'Online' : 'Offline';
          break;
        case ConnectivityResult.wifi:
          string = source.values.toList()[0] ? 'Online' : 'Offline';
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
      }
      // 2.
      update();
      // 3.
      Debug.printLog("connection status-------------------->$string");
    });
    if (Get.arguments != null) {
      if (Get.arguments[0] != null) {
        isTips = Get.arguments[0];
      }
      tipsData.clear();
      bankData.clear();
      if (isTips) {
        tipsData = Get.arguments[1];
        for (int i = 0; i < tipsData.length; i++) {
          tipsData[i].isMark = false;
        }
      } else {
        if (Get.arguments[1] != null) {
          bankData = Get.arguments[1];
          for (int i = 0;
              i < bankData[0].detail![mainIndex].dataList!.length;
              i++) {
            bankData[0].detail![mainIndex].dataList![i].isMark = false;
          }

          for(int i =0 ; i< bankData[0].detail![mainIndex].dataList!.length ; i++){
            bankData[0].detail![mainIndex].dataList![i].nativeInlinePage = NativeInlinePageSmallListData(context: Get.context!);
            Debug.printLog("NativeInlinePageSmallWithOutPreload.............");
          }
        }
      }

      if (Get.arguments[2] != null) {
        mainIndex = Get.arguments[2];
        if (isTips) {
          pageController = PageController(
              initialPage: mainIndex, keepPage: true, viewportFraction: 1);
        }
      }
      if (Get.arguments[3] != null) {
        subIndex = Get.arguments[3];
        if (!isTips) {
          pageController = PageController(
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

  getBookMarkData() {
    bookmarkCheckDataList.clear();
    if (Preference.shared.getString(Preference.bookMarkDetailData) != "") {
      var oldData = Preference.shared.getString(Preference.bookMarkDetailData);
      List<dynamic> rellyAStringList = jsonDecode(oldData.toString());
      for (Map bookMarkData in rellyAStringList) {
        Debug.printLog(
            "book mark data screen.......${jsonEncode(bookMarkData)}");
        var bookData = FaqTips(
            title: bookMarkData["title"],
            desc: bookMarkData["desc"],
            image: bookMarkData["image"]);
        bookmarkCheckDataList.add(bookData);
      }
    }

    if (isTips) {
      checkMarkData(pageIndexValue: mainIndex);
    } else {
      checkMarkData(pageIndexValue: subIndex);
    }
  }

  void checkMarkData({int? pageIndexValue}) {
    if (bookmarkCheckDataList.isNotEmpty) {
      if (isTips) {
        mainIndex = pageIndexValue!;
      } else {
        subIndex = pageIndexValue!;
      }
      for (int i = 0; i < bookmarkCheckDataList.length; i++) {
        if (isTips) {
          var listDataIndex = tipsData.indexWhere((element) =>
              element.title == bookmarkCheckDataList[i].title &&
              element.desc == bookmarkCheckDataList[i].desc);
          if (listDataIndex != -1 && pageIndexValue == listDataIndex) {
            tipsData[mainIndex].isMark = true;
            Debug.printLog(
                "index of bookmark data isTips ....$listDataIndex  $pageIndexValue");
            update([Constant.idAppBar]);
            break;
          }
        } else {
          var listDataIndex = bankData[0]
              .detail![mainIndex]
              .dataList!
              .indexWhere((element) =>
                  element.title == bookmarkCheckDataList[i].title &&
                  element.desc == bookmarkCheckDataList[i].desc);
          if (listDataIndex != -1 && pageIndexValue == listDataIndex) {
            bankData[0].detail![mainIndex].dataList![listDataIndex].isMark =
                true;
            Debug.printLog(
                "index of bookmark data....$listDataIndex  $pageIndexValue");
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

    if (isTips) {
      title = tipsData[pageViewIndex].title.toString();
      desc = tipsData[pageViewIndex].desc.toString();
      image = tipsData[pageViewIndex].image.toString();
      tipsData[pageViewIndex].isMark = true;
      mainIndex = pageViewIndex;
    } else {
      title = bankData[0]
          .detail![mainIndex]
          .dataList![pageViewIndex]
          .title
          .toString();
      desc = bankData[0]
          .detail![mainIndex]
          .dataList![pageViewIndex]
          .desc
          .toString();
      image = "";
      bankData[0].detail![mainIndex].dataList![pageViewIndex].isMark = true;
    }
    var bookMarkData = BookMarkDataClass(title, desc, image);
    var stringOldDatList = [];

    if (Preference.shared.getString(Preference.bookMarkDetailData) != "") {
      var oldData = Preference.shared.getString(Preference.bookMarkDetailData);
      List<dynamic> rellyAStringList = jsonDecode(oldData.toString());
      for (Map bookMarkData in rellyAStringList) {
        Debug.printLog("book mark data.......${jsonEncode(bookMarkData)}");
        stringOldDatList.add(json.encode(bookMarkData));
      }
    }
    stringOldDatList.add(json.encode(bookMarkData));
    Preference.shared
        .setString(Preference.bookMarkDetailData, stringOldDatList.toString());
    Debug.printLog(
        "Bookmark data..........${Preference.shared.getString(Preference.bookMarkDetailData)}");
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
    if (bookmarkCheckDataList.isNotEmpty) {
      var pageViewIndex = pageController.page!.toInt();
      var addedDataIndex = bookmarkCheckDataList.indexWhere((element) =>
          element.title == tipsData[pageViewIndex].title.toString() &&
          element.desc == tipsData[pageViewIndex].desc.toString());
      bookmarkCheckDataList.removeAt(addedDataIndex);
      if (bookmarkCheckDataList.isNotEmpty) {
        Preference.shared.setString(
            Preference.bookMarkDetailData, jsonEncode(bookmarkCheckDataList));
      } else {
        Preference.shared.setString(Preference.bookMarkDetailData, "");
      }
      tipsData[pageViewIndex].isMark = false;
    }
    Debug.printLog(
        "Bookmark......removeTipsBookMark........  ${bookmarkCheckDataList.length}");

    update([Constant.idAppBar]);
  }

  void removeBankDataBookMark() {
    getBookMarkData();
    if (bookmarkCheckDataList.isNotEmpty) {
      var pageViewIndex = pageController.page!.toInt();

      var addedDataIndex = bankData[0].detail![mainIndex].dataList!.indexWhere(
          (element) =>
              element.title ==
                  bankData[0]
                      .detail![mainIndex]
                      .dataList![pageViewIndex]
                      .title
                      .toString() &&
              element.desc ==
                  bankData[0]
                      .detail![mainIndex]
                      .dataList![pageViewIndex]
                      .desc
                      .toString());

      bankData[0].detail![mainIndex].dataList![pageViewIndex].isMark = false;

      bookmarkCheckDataList.removeAt(addedDataIndex);
      if (bookmarkCheckDataList.isNotEmpty) {
        Preference.shared.setString(
            Preference.bookMarkDetailData, jsonEncode(bookmarkCheckDataList));
      } else {
        Preference.shared.setString(Preference.bookMarkDetailData, "");
      }
    }
    Debug.printLog(
        "Bookmark......removeBankDataBookMark........  ${bookmarkCheckDataList.length}");

    update([Constant.idAppBar]);
  }

  void nextPrevPage(bool isNext) {
    getBookMarkData();
    if (isNext) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    } else {
      pageController.previousPage(
          duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    }
    update([Constant.idAppBar]);
  }

  @override
  void onClose() {
    Debug.preloadNativeBanner!.dispose();
    Debug.preloadNativeBanner = null;
    Utils.preLoadBannerNative();
    super.onClose();
  }

  void bookMarkTap() {
    var currentPage = pageController.page!.toInt();
    Debug.printLog("pageController.initialPage......${pageController.page}");
    // if(isTips && tipsData[mainIndex].isMark){
    if (isTips && tipsData[currentPage].isMark) {
      removeTipsBookMark();
    } else if (!isTips &&
        bankData[0].detail![mainIndex].dataList![currentPage].isMark) {
      // .dataList![subIndex].isMark){
      removeBankDataBookMark();
    } else {
      addBookmarkData();
    }
  }
}

class BookMarkDataClass {
  String title = "";
  String desc = "";
  String image = "";

  BookMarkDataClass(this.title, this.desc, this.image);

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
