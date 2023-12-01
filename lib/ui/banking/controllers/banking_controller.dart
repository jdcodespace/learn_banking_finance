import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_banking_finance/utils/constant.dart';
import '../../../ad_mediation/ad_load.dart';
import '../../../ad_mediation/ad_mediation.dart';
import '../../../datamodel/bank_data.dart';
import '../../../google_ads/ad_helper.dart';
import '../../../utils/debug.dart';
import '../../../utils/network_connectivity.dart';
import '../../../utils/utils.dart';
import '../../home/views/home_screen.dart';

class BankingController extends GetxController {
  dynamic argument = Get.arguments;
  CategoryFinanceClass? categoryFinanceClass;
  String blogTitle = "";
  String blogUrl = "";
  List<Accounting> blogData = [];
  List<Accounting> learnBankingData = [];
  List<Accounting> financeData = [];
  List<Accounting> savingAccountData = [];
  List<Accounting> loanGuideData = [];
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  NativeAd? bankingAd;

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
    /*Get arguments*/
    if(argument != null){
      if(argument[0] != null){
        categoryFinanceClass = argument[0];
      }
    }
    blogData = Constant.firebaseBankData.data!.bank!.where((element) =>element.title == "Blogs").toList();
    learnBankingData = Constant.firebaseBankData.data!.bank!.where((element) =>element.title == "LearnBanking").toList();
    financeData = Constant.firebaseBankData.data!.bank!.where((element) =>element.title == "Finance Guide").toList();
    savingAccountData = Constant.firebaseBankData.data!.bank!.where((element) =>element.title == "Saving Accounts").toList();
    loanGuideData = Constant.firebaseBankData.data!.bank!.where((element) =>element.title == "Personal Loan Guide").toList();
    for(var i = 0 ; i <  blogData[0].detail!.length ; ){
      blogTitle = blogData[0].detail![i].title.toString();
      blogUrl = blogData[0].detail![i].image.toString();
      break;
    }
    nativeSmallAd();
    super.onInit();
  }



  nativeSmallAd() async {
    await AdMediation.smallNativeMediation((ad) {
      bankingAd = ad;
      if (ad == null) {
        AdLoad.nativeSmallAd(AdHelper.nativeAdUnitIdAdx, (ad) {
          bankingAd = ad;
          if (ad == null) {
            Constant.isFacebookAd = true;
          }
        }, () {});
      }
    }, (value) {
      Constant.isFacebookAd = value;
    });
  }
  @override
  void onClose() {
    if(Debug.preloadNativeSmallBanking != null) {
      Debug.preloadNativeSmallBanking!.dispose();
      Debug.preloadNativeSmallBanking = null;
      // Utils.preLoadSmallNativeBanking();
    }
    super.onClose();
  }
}
