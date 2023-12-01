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
import '../../../utils/utils.dart';

class ListOfTaskController extends GetxController {

  String title = "";
  List<Accounting> dataList = [];
  int mainIndex = 0;
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  NativeAd? listOfTaskAd;

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
    if(Get.arguments != null){
      if(Get.arguments[0] != null){
        dataList = Get.arguments[0];
        title = Get.arguments[1];
        mainIndex = Get.arguments[2];
      }
    }
    nativeSmallAd();
    super.onInit();
  }

  nativeSmallAd() async {
    await AdMediation.smallNativeMediation((ad) {
      listOfTaskAd = ad;
      if (ad == null) {
        AdLoad.nativeSmallAd(AdHelper.nativeAdUnitIdAdx, (ad) {
          listOfTaskAd = ad;
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
