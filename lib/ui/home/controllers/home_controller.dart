import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_banking_finance/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../ad_mediation/ad_load.dart';
import '../../../ad_mediation/ad_mediation.dart';
import '../../../google_ads/ad_helper.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/debug.dart';
import '../../../utils/network_connectivity.dart';
import '../../../utils/preference.dart';
import '../../../utils/sizer_utils.dart';
import '../views/home_screen.dart';

class HomeController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController feedBackController = TextEditingController();
  List<ItemMenuClass> listData = [];
  List<CategoryFinanceClass> categoryListData = [];
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  NativeAd? homeAd;

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
    // NativeAd(
    //   adUnitId: AdHelper.nativeAdUnitId,
    //   factoryId: 'listTileSmall',
    //   request: const AdRequest(),
    //   listener: NativeAdListener(
    //     // Called when an ad is successfully received.
    //     onAdLoaded: (Ad ad) {
    //       var add = ad as NativeAd;
    //       Debug.printLog("**** AD NativeInlinePageSmallListData ***** ${add.responseInfo}");
    //       homeAd = add;
    //       update();
    //     },
    //     // Called when an ad request failed.
    //     onAdFailedToLoad: (Ad ad, LoadAdError error) {
    //       // Dispose the ad here to free resources.
    //       ad.dispose();
    //       homeAd = null;
    //       Debug.printLog(
    //           ' **** AD NativeInlinePageSmallListData *****  Ad load failed (code=${error.code} message=${error.message})');
    //     },
    //     // Called when an ad opens an overlay that covers the screen.
    //     onAdOpened: (Ad ad) => Debug.printLog('Ad opened.'),
    //     // Called when an ad removes an overlay that covers the screen.
    //     onAdClosed: (Ad ad) => Debug.printLog('Ad closed.'),
    //     // Called when an impression occurs on the ad.
    //     onAdImpression: (Ad ad) => Debug.printLog('Ad impression.'),
    //     // Called when a click is recorded for a NativeAd.
    //     onAdClicked: (Ad ad) => Debug.printLog('Ad clicked.'),
    //   ),
    // ).load();


    getDrawerListData();
    getCategoryListData();
    nativeSmallAd();
    // Utils.preLoadSmallNativeBanking();
    // Utils.preLoadSmallNativeAccount();
    super.onInit();
  }

  nativeSmallAd() async {
    await AdMediation.smallNativeMediation((ad) {
      homeAd = ad;
      if (ad == null) {
        AdLoad.nativeSmallAd(AdHelper.nativeAdUnitIdAdx, (ad) {
          homeAd = ad;
          if (ad == null) {
            Constant.isFacebookAd = true;
          }
        }, () {});
      }
    }, (value) {
      Constant.isFacebookAd = value;
    });
  }

  getDrawerListData() {
    listData.add(ItemMenuClass(
      Icon(
        Icons.home_rounded,
        color: CColor.borderColor,
        size: Sizes.height_3,
      ),
      "txtHome".tr,
      "txtHomeTransfer".tr,
    ));
    listData.add(ItemMenuClass(
      Icon(
        Icons.bookmark_border_rounded,
        color: CColor.borderColor,
        size: Sizes.height_3,
      ),
      "txtBookMark".tr,
      "txtBookMarkTransfer".tr,
    ));
    listData.add(ItemMenuClass(
      Icon(
        Icons.lock_rounded,
        color: CColor.borderColor,
        size: Sizes.height_3,
      ),
      "txtPrivacyPolicy".tr,
      "txtPrivacyPolicyTransfer".tr,
    ));
    listData.add(ItemMenuClass(
      Icon(
        Icons.star_rate_rounded,
        color: CColor.borderColor,
        size: Sizes.height_3,
      ),
      "txtRateApp".tr,
      "txtRateAppTransfer".tr,
    ));
    listData.add(ItemMenuClass(
      Icon(
        Icons.email_rounded,
        color: CColor.borderColor,
        size: Sizes.height_3,
      ),
      "txtFeedback".tr,
      "txtFeedBackTransfer".tr,
    ));
    listData.add(ItemMenuClass(
      Icon(
        Icons.thumb_up_rounded,
        color: CColor.borderColor,
        size: Sizes.height_3,
      ),
      "txtShareApp".tr,
      "txtShareAppTransfer".tr,
    ));
  }

  void getCategoryListData() {
    categoryListData
        .add(CategoryFinanceClass("assets/images/ic_bank.png", "txtCategoryBanking".tr, "/banking"));
    categoryListData.add(
        CategoryFinanceClass("assets/images/ic_accounting.png", "txtCategoryAccounting".tr, "/accounting"));
    categoryListData
        .add(CategoryFinanceClass("assets/images/ic_bookmark.png", "txtCategoryBookmarks".tr, "/bookMarks"));
    categoryListData
        .add(CategoryFinanceClass("assets/images/ic_tip.png", "txtCategoryTips".tr, "/tips"));
    categoryListData.add(CategoryFinanceClass("assets/images/ic_faq.png", "txtCategoryFAQ".tr, "/faq"));
  }

  drawerTransfer(ItemMenuClass listData) {
    if (listData.screenName == "txtPrivacyPolicyTransfer".tr) {
      Get.toNamed(AppRoutes.webView);
    }
    if (listData.screenName == "txtHomeTransfer".tr) {
      Get.toNamed(AppRoutes.home);
    }
    if (listData.screenName == "txtBookMarkTransfer".tr) {
      Get.toNamed(AppRoutes.bookMarks);
    }
    if (listData.screenName == "txtRateAppTransfer".tr) {
      openPlayStore();
    }
    if (listData.screenName == "txtFeedBackTransfer".tr) {
      feedbackEmail();
    }
    if (listData.screenName == "txtShareAppTransfer".tr) {
      shareLink();
    }
  }

  openPlayStore() {
    const appId = 'com.goofystudio.learn.bank.finance.guide';
    final url = Uri.parse(
      "https://play.google.com/store/apps/details?id=$appId",
    );
    launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  feedbackEmail() async {
    String email = Uri.encodeComponent("goofyappstudio@gmail.com");
    Uri mail = Uri.parse("mailto:$email");
    launchUrl(mail);
  }

  shareLink() {
    const appId = 'com.goofystudio.learn.bank.finance.guide';
    Share.share("https://play.google.com/store/apps/details?id=$appId");
  }

}
