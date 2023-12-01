import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../ad_loader/ad_loader.dart';
import '../../ad_loader/ad_loader_mediation.dart';
import '../../dialog/progressdialog.dart';
import '../../google_ads/ad_helper.dart';
import '../../utils/constant.dart';
import '../../utils/debug.dart';
import '../../utils/preference.dart';
import '../../utils/utils.dart';

class InterstitialAdClass {
  static void showInterstitialAdInterCount(
      BuildContext context, Function callBack) {
    if (Debug.isShowAd &&
        Debug.isShowInter){
      AdLoaderMediation.interCountMediation(() {
        if (Constant.interGoogleAd == null &&
            Constant.interGoogleAdxAd == null &&
            !Constant.isFacebookAdLoader &&
            Debug.totalAdInterCount <= Preference.currentAdCount) {
          Get.back();
        }
        if (Debug.totalAdInterCount <= Preference.currentAdCount) {
          Utils.showLoader(context);
        }
        Future.delayed(const Duration(milliseconds: 500), () {
          if (Debug.totalAdInterCount <= Preference.currentAdCount) {
            Utils.hideLoader();
          }
          callBack.call();
        });
      });
    }else {
      callBack.call();
    }
  }

  static void showInterstitialAdForceShow(
      BuildContext context, Function callBack) {
    if (Debug.isShowAd && Debug.isShowInter) {
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
      }
      InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            Navigator.pop(context);
            ad.show();
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                callBack.call();
              },
            );
          },
          onAdFailedToLoad: (err) {
            callBack.call();
          },
        ),
      );
    } else {
      callBack.call();
    }
  }

  static void showInterstitialAdForSplash(Function callBack) {
/*
    if (Debug.isShowAd && Debug.isShowInter) {
      InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.show();
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                callBack.call();
              },
            );
          },

          onAdFailedToLoad: (err) {
            callBack.call();
          },
        ),
      );
    } else {
      callBack.call();
    }
*/
  }
}
