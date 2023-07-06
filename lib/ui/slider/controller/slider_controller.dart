import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_banking_finance/utils/constant.dart';
import '../../../datamodel/bank_data.dart';
import '../../../utils/debug.dart';
import '../../../utils/network_connectivity.dart';
import '../../../utils/utils.dart';

class SliderController extends GetxController{
  RxInt selectedIndex = 0.obs;
int totalIndex = 0;
  PageController pageController =
  PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
List<SliderData> sliderData = [];
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  NativeAd? sliderAd;


  changeIndex(value) {
    selectedIndex.value = value;
    update();
  }
  // @override
  // void onClose() {
  //   if(Debug.preloadNativeSmallHome  != null) {
  //     Debug.preloadNativeSmallHome!.dispose();
  //     Debug.preloadNativeSmallHome = null;
  //     Utils.preLoadSmallNative();
  //   }
  //   super.onClose();
  // }
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
    nativeHomeAd();
    sliderData = Constant.firebaseBankData.data!.slider!;
    super.onInit();
  }

  nativeHomeAd() {
    Utils.nativeAd((value) {
      sliderAd = value;
      update();
    });
  }
}