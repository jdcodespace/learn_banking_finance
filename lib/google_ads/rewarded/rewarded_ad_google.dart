import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../dialog/progressdialog.dart';
import '../../utils/debug.dart';
import '../ad_helper.dart';

class RewardedGoogle{
  static loadShowRewardedGoogle(BuildContext context, Function callBack) {
    if (Debug.isShowAd && Debug.isShowRewarded) {
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
      RewardedAd.load(
        adUnitId: AdHelper.rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            Navigator.pop(context);
            // Navigator.pop(context);
            ad.show(
              onUserEarnedReward: (ad, reward) {},
            );
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
    }else{
      callBack.call();
    }
  }

}