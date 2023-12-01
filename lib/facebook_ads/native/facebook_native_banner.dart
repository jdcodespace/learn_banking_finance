import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../google_ads/ad_helper.dart';
import '../../utils/color.dart';
import '../../utils/debug.dart';

class FacebookBannerNative extends StatefulWidget {
  const FacebookBannerNative({Key? key}) : super(key: key);

  @override
  State<FacebookBannerNative> createState() => _FacebookBannerNativeState();
}

class _FacebookBannerNativeState extends State<FacebookBannerNative> {
  @override
  Widget build(BuildContext context) {
    return smallNativeAdFacebook(context);
  }

  Widget smallNativeAdFacebook(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: FacebookNativeAd(
        height: Get.height * 0.055,
        // bannerAdSize: NativeBannerAdSize.HEIGHT_50,
        placementId: AdHelper.bannerAdUnitIdFacebook,
        adType: NativeAdType.NATIVE_BANNER_AD,
        backgroundColor: CColor.backgroundColor,

        titleColor:  Colors.black,
        descriptionColor: Colors.black,
        buttonColor: CColor.black12,
        buttonTitleColor: Colors.white,
        buttonBorderColor: Colors.black,
        isMediaCover: false,
        listener: (result, value) {
          Debug.printLog("Native Ad: $result --> $value");
        },
        keepExpandedWhileLoading: true,
        expandAnimationDuraion: 1000,
      ),
    );
  }
}
