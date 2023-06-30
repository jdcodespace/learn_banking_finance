import 'package:facebook_audience_network/ad/ad_rewarded.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dialog/progressdialog.dart';
import '../../utils/debug.dart';

class FacebookRewardedAd {
  static void showFacebookRewardedAd(BuildContext context,Function callBack) {
    if (Debug.isShowAd &&
        Debug.isShowRewarded) {
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

      FacebookRewardedVideoAd.loadRewardedVideoAd(
        placementId: "YOUR_PLACEMENT_ID",
        listener: (result, value) {
          Debug.printLog("Rewarded Ad: $result --> $value");
          if (result == RewardedVideoAdResult.LOADED) {
            Get.back();
            FacebookRewardedVideoAd.showRewardedVideoAd();
          }
          if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {}
          if (result == RewardedVideoAdResult.VIDEO_CLOSED) {
            callBack.call();
          }
        },
      );
    }else{
      callBack.call();
    }
  }
}
