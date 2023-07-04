import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_banking_finance/utils/constant.dart';
import 'package:learn_banking_finance/utils/preference.dart';

import '../google_ads/ad_helper.dart';
import 'debug.dart';


class Utils{
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

  static preloadNormalNativeAds(){
    Debug.preloadNativeNormal = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          Debug.printLog('Normal Ad load success preload.......');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
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
    );
    Debug.preloadNativeNormal!.load();
  }


  static preLoadBannerNative() async {
    /*native banner*/
    Debug.preloadNativeBanner = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTileBanner',
      request: const AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          Debug.printLog('Ad load success preload.......');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          Debug.printLog(
              'Ad load failed (code=${error.code} message=${error.message})');
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
    );
    Debug.preloadNativeBanner!.load();
  }
}