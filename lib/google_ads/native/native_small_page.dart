import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/debug.dart';
import '../ad_helper.dart';

class NativeInlinePageSmall extends StatefulWidget {
  final BuildContext context;

  const NativeInlinePageSmall({super.key, required this.context});

  @override
  State<NativeInlinePageSmall> createState() => _NativeInlinePageSmallState();
}

class _NativeInlinePageSmallState extends State<NativeInlinePageSmall> {
  NativeAd? _ad;
  bool isAdLoaded = false;

  @override
  void initState() {
    Debug.printLog("*************** INIT STATE ***************");
    super.initState();
    if (Debug.preloadNativeSmall != null) {
      _ad = Debug.preloadNativeSmall;
      Debug.printLog("*************** INIT small STATE ***************");
    }else {
      _ad = NativeAd(
        adUnitId: AdHelper.nativeAdUnitId,
        factoryId: 'listTileSmall',
        request: const AdRequest(),
        listener: NativeAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (Ad ad) {
            var add = ad as NativeAd;
            Debug.printLog("**** AD ***** ${add.responseInfo}");
            setState(() {
              _ad = add;
              isAdLoaded = true;
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            // Dispose the ad here to free resources.
            ad.dispose();
            Debug.printLog(
                'Ad load failed (code=${error.code} message=${error.message})');
          },
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (Ad ad) => Debug.printLog('Ad opened.'),
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (Ad ad) => Debug.printLog('Ad closed.'),
          // Called when an impression occurs on the ad.
          onAdImpression: (Ad ad) => Debug.printLog('Ad impression.'),
          // Called when a click is recorded for a NativeAd.
          onAdClicked: (Ad ad) => Debug.printLog('Ad clicked.'),
        ),
      );

      _ad!.load();
    }
  }

  @override
  void dispose() {
    Debug.printLog("*********** DISPOSING **********");
    _ad?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ad != null && Debug.isShowAd && Debug.isNativeAd || isAdLoaded
        ? Container(
            height: 220.0,
            alignment: Alignment.center,
            child: AdWidget(ad: _ad!),
          )
        : Container(
            height: 0,
          );
  }
}
