import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../utils/debug.dart';
import '../ad_helper.dart';

class NativeInlinePage extends StatefulWidget {
  // const NativeInlinePage({super.key});
  final BuildContext context;

  const NativeInlinePage({super.key, required this.context});

  @override
  State<NativeInlinePage> createState() => _NativeInlinePageState();
}

class _NativeInlinePageState extends State<NativeInlinePage> {
  NativeAd? _ad;
  bool isAdLoaded = false;

  @override
  void initState() {
    if (kDebugMode) {
      print("*************** INIT STATE ***************");
    }
    super.initState();

    if (Debug.preloadNativeNormal != null) {
      _ad = Debug.preloadNativeNormal;
    } else {
      _ad = NativeAd(
        adUnitId: AdHelper.nativeAdUnitId,
        factoryId: 'listTile',
        request: const AdRequest(),
        listener: NativeAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (Ad ad) {
            var add = ad as NativeAd;
            if (kDebugMode) {
              print("**** AD ***** ${add.responseInfo}");
            }
            setState(() {
              _ad = add;
              isAdLoaded = true;
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            // Dispose the ad here to free resources.
            ad.dispose();
            if (kDebugMode) {
              print(
                  'Ad load failed (code=${error.code} message=${error.message})');
            }
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
    if (Debug.preloadNativeNormal != null) {
      Debug.preloadNativeNormal!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Debug.preloadNativeNormal != null) {
      return _ad != null && Debug.isShowAd && Debug.isNativeAd
          ? Container(
              height: 400.0,
              alignment: Alignment.center,
              child: AdWidget(ad: _ad!),
            )
          : Container(
              height: 0,
            );
    } else {
      return _ad != null && isAdLoaded && Debug.isShowAd && Debug.isNativeAd
          ? Container(
              height: 400.0,
              alignment: Alignment.center,
              child: AdWidget(ad: _ad!),
            )
          : Container(
              height: 0,
            );
    }
  }
}
