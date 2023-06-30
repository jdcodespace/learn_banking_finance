import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dialog/progressdialog.dart';
import '../../google_ads/ad_helper.dart';
import '../../google_ads/inter/interAd.dart';
import '../../utils/debug.dart';
import '../../utils/preference.dart';

loadInterFacebookOutCat(BuildContext context, Function callBack) {
  int totalAttempt = 1;
  try {
    if (totalAttempt <= 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return ProgressLoadingDialog(inAsyncCall: true, child: Container());
          });
    }
  } catch (e) {
    Debug.printLog(e.toString());
    Get.back();
    Preference.currentAdCount = 1;
  }
  FacebookInterstitialAd.loadInterstitialAd(
    placementId: AdHelper.interstitialAdUnitIdFacebook,
    listener: (result, value) {
      if (result == InterstitialAdResult.LOADED) {
        Get.back();
        FacebookInterstitialAd.showInterstitialAd();
      }

      if (result == InterstitialAdResult.ERROR) {
        if (totalAttempt >= Preference.totalAttemptCount) {
          Get.back();
          totalAttempt = 1;
          loadAd(() {
            callBack.call();
          }, context);
        } else {
          totalAttempt++;
          loadInterFacebookOutCat(context, () {});
        }
      }

      if (result == InterstitialAdResult.DISMISSED) {
        callBack.call();
        Preference.currentAdCount = 1;
      }
    },
  );
}
