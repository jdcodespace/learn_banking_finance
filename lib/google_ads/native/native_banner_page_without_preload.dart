import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/debug.dart';
import '../ad_helper.dart';

class NativeInlinePageBannerWithoutPreload extends StatefulWidget {
  final BuildContext context;
  final Function function;

  const NativeInlinePageBannerWithoutPreload(
      {super.key, required this.context, required this.function});

  @override
  State<NativeInlinePageBannerWithoutPreload> createState() =>
      _NativeInlinePageBannerWithoutPreloadState();
}

class _NativeInlinePageBannerWithoutPreloadState
    extends State<NativeInlinePageBannerWithoutPreload> {
  NativeAd? _ad;
  bool isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    Debug.printLog(
        "_NativeInlinePageBannerWithoutPreloadState Init ${AdHelper.nativeAdUnitId}");

    _ad = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTileBanner',
      request: const AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          var add = ad as NativeAd;
          Debug.printLog(
              "_NativeInlinePageBannerWithoutPreloadState **** AD ***** ${add.responseInfo}");
          setState(() {
            _ad = add;
            isAdLoaded = true;
          });
          widget.function.call(true);
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          widget.function.call(false);
          Debug.printLog(
              '_NativeInlinePageBannerWithoutPreloadState Ad load failed (code=${error.code} message=${error.message})');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => Debug.printLog(
            '_NativeInlinePageBannerWithoutPreloadState Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => Debug.printLog(
            '_NativeInlinePageBannerWithoutPreloadState Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => Debug.printLog(
            '_NativeInlinePageBannerWithoutPreloadState Ad impression.'),
        // Called when a click is recorded for a NativeAd.
        onAdClicked: (Ad ad) => Debug.printLog(
            '_NativeInlinePageBannerWithoutPreloadState Ad clicked.'),
      ),
    );
    _ad!.load();
  }

  @override
  void dispose() {
    Debug.printLog("*********** DISPOSING **********");
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Debug.printLog("*************** INIT NATIVE BANNER ***************");
    return _ad != null && isAdLoaded && Debug.isShowAd && Debug.isNativeAd
        ? Container(
            height: 65.0,
            alignment: Alignment.center,
            child: AdWidget(ad: _ad!),
          )
        : Container(
            height: 0,
          );
  }
}
