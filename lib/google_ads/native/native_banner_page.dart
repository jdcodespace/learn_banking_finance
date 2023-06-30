import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/debug.dart';
import '../ad_helper.dart';

class NativeInlinePageBanner extends StatefulWidget {
  final BuildContext context;

  const NativeInlinePageBanner({super.key, required this.context});

  @override
  State<NativeInlinePageBanner> createState() => _NativeInlinePageBannerState();
}

class _NativeInlinePageBannerState extends State<NativeInlinePageBanner> {
  NativeAd? _ad;
  bool isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    if(Debug.preloadNativeBanner != null) {
      _ad = Debug.preloadNativeBanner;
    }else {
      if(Theme.of(widget.context).secondaryHeaderColor == Colors.white){
      _ad = NativeAd(
        adUnitId: AdHelper.nativeAdUnitId,
        factoryId: 'listTileBannerNight',
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
            Debug.printLog('Ad load failed (code=${error.code} message=${error.message})');
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
    }
    else{
      _ad = NativeAd(
        adUnitId: AdHelper.nativeAdUnitId,
        factoryId: 'listTileBanner',
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
            Debug.printLog('Ad load failed (code=${error.code} message=${error.message})');
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
  }

  @override
  void dispose() {
    Debug.printLog("*********** DISPOSING **********");
    _ad?.dispose();
    if(Debug.preloadNativeBanner != null) {
      Debug.preloadNativeBanner!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Debug.printLog("*************** INIT NATIVE BANNER ***************");

    if(Debug.preloadNativeBanner != null) {
      return _ad != null && Debug.isShowAd && Debug.isNativeAd
          ? Container(
        height: 65.0,
        alignment: Alignment.center,
        child: AdWidget(ad: _ad!),
      )
          : Container(
        height: 0,
      );
    }else{
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
}