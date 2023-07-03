import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
import '../../../utils/debug.dart';
import '../../../utils/network_connectivity.dart';
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
    getDrawerListData();
    getCategoryListData();
    super.onInit();
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
        .add(CategoryFinanceClass("", "txtCategoryBanking".tr, "/banking"));
    categoryListData.add(
        CategoryFinanceClass("", "txtCategoryAccounting".tr, "/accounting"));
    categoryListData
        .add(CategoryFinanceClass("", "txtCategoryBookmarks".tr, "/bookMarks"));
    categoryListData
        .add(CategoryFinanceClass("", "txtCategoryTips".tr, "/tips"));
    categoryListData.add(CategoryFinanceClass("", "txtCategoryFAQ".tr, "/faq"));
  }

  drawerTransfer(ItemMenuClass listData) {
    if (listData.screenName == "txtPrivacyPolicyTransfer".tr) {
      Get.toNamed(AppRoutes.webView);
    }
    if (listData.screenName == "txtHomeTransfer".tr) {
      Get.back();
    }
    if (listData.screenName == "txtBookMarkTransfer".tr) {}
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
    const appId = 'com.example.spotify_flutter_code';
    final url = Uri.parse(
      "https://play.google.com/store/apps/details?id=$appId",
    );
    launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  feedbackEmail() async {
    String email = Uri.encodeComponent("tilakdhameliya@gmail.com");
    Uri mail = Uri.parse("mailto:$email");
    launchUrl(mail);
  }

  shareLink() {
    const appId = 'com.example.spotify_flutter_code';
    Share.share("https://play.google.com/store/apps/details?id=$appId");
  }

  @override
  void onClose() {
    Debug.preloadNativeSmall!.dispose();
    super.onClose();
  }
}
