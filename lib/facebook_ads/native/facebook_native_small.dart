import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

import '../../google_ads/ad_helper.dart';
import '../../utils/color.dart';
import '../../utils/debug.dart';


class NativeAdFacebookSmall extends StatefulWidget {
  const NativeAdFacebookSmall({Key? key}) : super(key: key);

  @override
  State<NativeAdFacebookSmall> createState() => _NativeAdFacebookSmallState();
}

class _NativeAdFacebookSmallState extends State<NativeAdFacebookSmall> {
  @override
  Widget build(BuildContext context) {
    return smallNativeAdFacebook(context);
  }
}

Widget smallNativeAdFacebook(BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: FacebookNativeAd(
      placementId: AdHelper.nativeAdUnitIdFacebookSmall,
      adType: NativeAdType.NATIVE_AD,
      backgroundColor: CColor.backgroundColor,
      titleColor:Colors.black,
      descriptionColor: Colors.black,
      buttonColor: CColor.black12,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.black,
      isMediaCover: false,

      listener: (result, value) {
        if (result == NativeAdResult.ERROR) {
        } else if (result == NativeAdResult.LOADED) {
        }

        Debug.printLog("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    ),
  );
}
