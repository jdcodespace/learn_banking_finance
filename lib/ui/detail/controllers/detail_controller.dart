import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_banking_finance/datamodel/bank_data.dart';
import 'package:learn_banking_finance/google_ads/native/native_inline_page.dart';
import 'package:learn_banking_finance/main.dart';

import '../../../google_ads/native/native_inline_page_list_data.dart';
import '../../../google_ads/native/native_small_page_list_data.dart';
import '../../../utils/debug.dart';
import '../../../utils/network_connectivity.dart';
import '../../../utils/utils.dart';

class DetailController extends GetxController {
  List<Accounting> bankData = [];
  List<FaqTips> tipsData = [];
  int mainIndex = 0;
  bool isTips = false ;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
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
      if(isTips == true){
        tipsData = Get.arguments[1];
      }else{
        bankData = Get.arguments[1];
        for(int i =0 ; i< bankData[0].detail![mainIndex].dataList!.length ; i++){
          bankData[0].detail![mainIndex].dataList![i].nativeInlinePage = NativeInlinePageSmallListData(context: Get.context!);
          Debug.printLog("NativeInlinePageSmallWithOutPreload.............");
        }
      }
      if (Get.arguments[2] != null) {
        mainIndex = Get.arguments[2];
      }
    }
    super.onInit();
  }

  @override
  void onClose() {
    Debug.preloadNativeBanner!.dispose();
    Debug.preloadNativeBanner = null;
    Utils.preLoadBannerNative();
    super.onClose();
  }
}
