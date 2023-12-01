import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../ad_mediation/ad_load.dart';
import '../../../ad_mediation/ad_mediation.dart';
import '../../../datamodel/bank_data.dart';
import '../../../google_ads/ad_helper.dart';
import '../../../utils/constant.dart';
import '../../../utils/debug.dart';
import '../../../utils/network_connectivity.dart';
import '../../../utils/preference.dart';
import '../../../utils/utils.dart';

class BookMarkController extends GetxController {
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  List<FaqTips> listData = [];
  NativeAd? bookMarkAd;

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
    nativeSmallAd();
    getBookMarkData();
    super.onInit();
  }

  getBookMarkData() {
    listData.clear();
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
        listData.add(bookData);
      }
    }
    update();
  }

  nativeSmallAd() async {
    await AdMediation.smallNativeMediation((ad) {
      bookMarkAd = ad;
      if (ad == null) {
        AdLoad.nativeSmallAd(AdHelper.nativeAdUnitIdAdx, (ad) {
          bookMarkAd = ad;
          if (ad == null) {
            Constant.isFacebookAd = true;
          }
        }, () {});
      }
    }, (value) {
      Constant.isFacebookAd = value;
    });
  }
}
