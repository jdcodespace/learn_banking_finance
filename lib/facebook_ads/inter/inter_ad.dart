import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dialog/progressdialog.dart';
import '../../google_ads/ad_helper.dart';
import '../../utils/debug.dart';
import '../../utils/preference.dart';

class InterstitialFacebookAdClass {

  static void showInterstitialFacebookAdInterCount(BuildContext context,
      Function callBack) {
    if (Debug.isShowAd &&
        Debug.isShowInter &&
        Debug.totalAdInterCount <= Preference.currentAdCount) {
      try {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return ProgressLoadingDialog(
                  inAsyncCall: true, child: Container());
            });
      } catch (e) {
        Debug.printLog(e.toString());
        Get.back();
      }

      FacebookInterstitialAd.loadInterstitialAd(
        placementId: AdHelper.interstitialAdUnitIdFacebook,
        listener: (result, value) {
          if (result == InterstitialAdResult.LOADED) {
            Get.back();
            FacebookInterstitialAd.showInterstitialAd();
          }

          if (result == InterstitialAdResult.ERROR) {}

          if (result == InterstitialAdResult.DISMISSED) {
            callBack.call();
          }
        },
      );
    } else {
      Preference.currentAdCount++;
      callBack.call();
    }
  }

  static void showInterstitialFacebookAdForceShow(BuildContext context,
      Function callBack) {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return ProgressLoadingDialog(inAsyncCall: true, child: Container());
          });
    } catch (e) {
      Debug.printLog(e.toString());
      Get.back();
    }

    FacebookInterstitialAd.loadInterstitialAd(
      placementId: AdHelper.interstitialAdUnitIdFacebook,
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED) {
          Get.back();
          FacebookInterstitialAd.showInterstitialAd();
        }

        if (result == InterstitialAdResult.ERROR) {}

        if (result == InterstitialAdResult.DISMISSED) {
          callBack.call();
        }
      },
    );
  }

  static void showInterstitialFacebookAdForSplash(Function callBack) {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: AdHelper.interstitialAdUnitIdFacebook,
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED) {
          Get.back();
          FacebookInterstitialAd.showInterstitialAd();
        }

        if (result == InterstitialAdResult.ERROR) {}

        if (result == InterstitialAdResult.DISMISSED) {
          callBack.call();
        }
      },
    );
  }
}