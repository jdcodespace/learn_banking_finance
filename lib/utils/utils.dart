import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/constant.dart';
import 'package:learn_banking_finance/utils/preference.dart';

import '../facebook_ads/native/facebook_native_small.dart';
import '../google_ads/ad_helper.dart';
import 'debug.dart';

class Utils {
  static showToast(BuildContext context, String msg) {
    return Fluttertoast.showToast(
      msg: "This is toast",
    );
  }

  static bool isFirstTime() {
    return Preference.shared.getBool(Preference.isFirstTime) ?? true;
  }

  static String getSelectedLanguage() {
    return Preference.shared.getString(Preference.selectedLanguage) ??
        Constant.languageEn;
  }

  static bool isLogin() {
    var accessToken = Preference.shared.getString(Preference.accessToken);
    return (accessToken != null && accessToken.isNotEmpty);
  }

  static nativeAd(Function callBack) {
    NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTileSmall',
      request: const AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          var add = ad as NativeAd;
          Debug.printLog(
              "**** AD NativeInlinePageSmallListData ***** ${add.responseInfo}");
          callBack.call(add);
          // callBack.call();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          callBack.call(null);
          Debug.printLog(
              ' **** AD NativeInlinePageSmallListData *****  Ad load failed (code=${error.code} message=${error.message})');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => Debug.printLog('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => Debug.printLog('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => Debug.printLog('Ad impression.'),
        // Called when a click is recorded for a NativeAd.
        onAdClicked: (Ad ad) => Debug.printLog('Ad clicked.'),
      ),
    ).load();
  }

  static Widget? smallNativeAd(NativeAd? homeAd, BuildContext context) {
    return Container(
      child: (Debug.adType == Debug.adGoogleType &&
              Debug.isShowAd &&
              Debug.isNativeAd)
          ? (homeAd != null)
              ? Container(
                  // margin: EdgeInsets.only(bottom: Get.height * 0.005),
                  decoration: BoxDecoration(
                    color: CColor.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: Get.height * 0.22,
                  child: AdWidget(ad: homeAd),
                )
              : Container()
          : smallNativeAdFacebook(context),
    );
  }
}
