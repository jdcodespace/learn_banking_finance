import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/debug.dart';
import '../ad_helper.dart';

class NativeBannerNormalBottomAd extends StatefulWidget {
  final BuildContext context;

  const NativeBannerNormalBottomAd({super.key, required this.context});

  @override
  State<NativeBannerNormalBottomAd> createState() => _NativeBannerNormalBottomAdState();
}

class _NativeBannerNormalBottomAdState extends State<NativeBannerNormalBottomAd> {
  NativeAd? _ad;
  bool isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    if(Theme.of(widget.context).secondaryHeaderColor == Colors.white){
      _ad = NativeAd(
        adUnitId: AdHelper.nativeAdUnitId,
        factoryId: 'listTileNativeAdBottomSheetNight',
        request: const AdRequest(),
        listener: NativeAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (Ad ad) {
            var add = ad as NativeAd;
            setState(() {
              _ad = add;
              isAdLoaded = true;
              _generateRandomString(add);
              Debug.printLog("**** AD Native banner night***** ${add.responseInfo}");
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
        factoryId: 'listTileNativeAdBottomSheet',
        request: const AdRequest(),
        listener: NativeAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (Ad ad) {
            var add = ad as NativeAd;
            setState(() {
              _ad = add;
              isAdLoaded = true;
              Debug.printLog("**** AD Native banner light***** ${add.responseInfo}");
              _generateRandomString(add);
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

  Future<void> _generateRandomString(NativeAd add) async {
    const platform = MethodChannel('nativeAdChannel');
    try {
      await platform.invokeMethod('nativeAdFromBanner', {});
    } on PlatformException catch (e) {
      Debug.printLog("error on method channel.......${e.message}");
    }
  }

}