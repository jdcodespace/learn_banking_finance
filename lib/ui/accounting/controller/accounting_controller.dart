import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../../datamodel/bank_data.dart';
import '../../../utils/constant.dart';
import '../../../utils/debug.dart';
import '../../../utils/network_connectivity.dart';
import '../../home/views/home_screen.dart';

class AccountingController extends GetxController {
  dynamic argument = Get.arguments;
  List<Accounting> blogData = [];
  List<Accounting> introductionData = [];
  List<Accounting> accountingData = [];
  List<Accounting> evolutionData = [];
  List<Accounting> advancedTopicData = [];
  String blogTitle = "";
  String learnTitle = "";
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  CategoryFinanceClass? categoryFinanceClass;

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
    if (argument != null) {
      if (argument[0] != null) {
        categoryFinanceClass = argument[0];
      }
    }
    blogData = Constant.firebaseBankData.data!.accounting!
        .where((element) => element.title == "Blogs")
        .toList();
    introductionData = Constant.firebaseBankData.data!.accounting!
        .where((element) => element.title == "Introduction")
        .toList();
    accountingData = Constant.firebaseBankData.data!.accounting!
        .where((element) => element.title == "Accounting Basics")
        .toList();
    evolutionData = Constant.firebaseBankData.data!.accounting!
        .where((element) => element.title == "Evolution of Accounting")
        .toList();
    advancedTopicData = Constant.firebaseBankData.data!.accounting!
        .where((element) => element.title == "Advanced Topics")
        .toList();
    for (var i = 0; i < blogData[0].detail!.length; i++) {
      blogTitle = blogData[0].detail![i].title.toString();
      break;
    }

    super.onInit();
  }
}
