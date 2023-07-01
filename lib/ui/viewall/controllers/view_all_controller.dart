import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/utils/constant.dart';

import '../../../datamodel/bank_data.dart';
import '../../../utils/debug.dart';
import '../../../utils/network_connectivity.dart';

class ViewAllController extends GetxController {

  String title = "";
  dynamic arguments = Get.arguments;
  List<Accounting> bankData = [];
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
    if(arguments != null){
      if(arguments[0] != null){
        title = arguments[0];
      }
      if(arguments[1] != null){
        bankData = arguments[1];
      }
    }
    super.onInit();
  }

}
