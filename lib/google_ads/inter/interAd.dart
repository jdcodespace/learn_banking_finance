import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


import '../../dialog/progressdialog.dart';
import '../../utils/debug.dart';
import '../../utils/preference.dart';
import '../ad_helper.dart';

void loadAd(Function callBack,BuildContext context) {
  if (Debug.isShowAd) {
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
      Preference.currentAdCount = 1;
    }
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (InterstitialAd ad) {
          Get.back();
          ad.show();
          ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                callBack.call();
                Preference.currentAdCount = 1;
              },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {});

          // Keep a reference to the ad so you can show it later.
          // _interstitialAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          // ignore: avoid_print

          callBack.call();
          Preference.currentAdCount = 1;
          Debug.printLog('InterstitialAd failed to load: $error');
        },
      ),
    );
  }
}
