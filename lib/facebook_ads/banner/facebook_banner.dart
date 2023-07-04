import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';

import '../../utils/debug.dart';

class FacebookBanner extends StatefulWidget {
  const FacebookBanner({Key? key}) : super(key: key);

  @override
  State<FacebookBanner> createState() => _FacebookBannerState();
}

class _FacebookBannerState extends State<FacebookBanner> {
  @override
  Widget build(BuildContext context) {
    return FacebookBannerAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: Debug.facebookBanner,
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        Debug.printLog("Banner Ad: $result -->  $value");
      },
    );
  }
}
