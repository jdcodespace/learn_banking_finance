import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

import '../../google_ads/ad_helper.dart';
import '../../utils/color.dart';
import '../../utils/debug.dart';


int totalAttemptNativeAd = 1;

Widget nativeAdFacebook() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: FacebookNativeAd(
      placementId: AdHelper.nativeAdUnitIdFacebook,
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.white,
      titleColor: CColor.gray,
      descriptionColor: Colors.white,
      buttonColor: CColor.black,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      isMediaCover: false,
      listener: (result, value) {
        if (result == NativeAdResult.ERROR) {
          totalAttemptNativeAd++;
          nativeAdFacebook();
        } else if (result == NativeAdResult.LOADED) {
          totalAttemptNativeAd = 1;
        }

        Debug.printLog("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    ),
  );
}
