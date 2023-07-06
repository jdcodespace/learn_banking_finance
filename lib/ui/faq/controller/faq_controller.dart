import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../datamodel/bank_data.dart';
import '../../../utils/constant.dart';
import '../../../utils/debug.dart';
import '../../../utils/network_connectivity.dart';
import '../../../utils/utils.dart';
import '../../home/views/home_screen.dart';

class FaqController extends GetxController{

  dynamic argument = Get.arguments;
  List<FaqTips> faqData = [];
  String blogTitle = "";
  String learnTitle = "";
  CategoryFinanceClass? categoryFinanceClass;
 int selectedIndex = 0;
  NativeAd? faqAd;



  dataVisible(int index){
    selectedIndex = index;
    faqData[index].isFaqShow = !faqData[index].isFaqShow;
    update();
  }


  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';

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
    if(argument != null){
      if(argument[0] != null){
        categoryFinanceClass = argument[0];
      }
    }
    faqData = Constant.firebaseBankData.data!.faq!.toList();
    nativeHomeAd();
    super.onInit();
  }
  nativeHomeAd() {
    Utils.nativeAd((value) {
      faqAd = value;
      update();
    });
  }
}