import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../dialog/progressdialog.dart';
import '../google_ads/ad_helper.dart';
import '../utils/color.dart';
import '../utils/constant.dart';
import '../utils/debug.dart';
import '../utils/sizer_utils.dart';

class AdLoad {
  static googleInter(
      String adId, Function onLoad, Function onFailed, Function onDismissed,
      {bool isLoader = true}) {
    if (Debug.isShowAd && Debug.isShowInter) {
      if (isLoader) {
        try {
          showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (context) {
                return ProgressLoadingDialog(
                    inAsyncCall: true, child: Container());
              });
        } catch (e) {
          Debug.printLog(e.toString());
        }
      }
      InterstitialAd.load(
        adUnitId: adId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.show();
            onLoad.call();
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                onDismissed.call();
              },
            );
          },
          onAdFailedToLoad: (err) {
            onFailed.call();
          },
        ),
      );
    } else {
      onDismissed.call();
    }
  }

  static facebookInter(
      String adId, Function onLoad, Function onFailed, Function onDismissed,
      {bool isLoader = true}) {
    if (Debug.isShowAd && Debug.isShowInter) {
      if (isLoader) {
        try {
          showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (context) {
                return ProgressLoadingDialog(
                    inAsyncCall: true, child: Container());
              });
        } catch (e) {
          Debug.printLog(e.toString());
          Get.back();
        }
      }
      FacebookInterstitialAd.loadInterstitialAd(
        placementId: adId,
        listener: (result, value) {
          if (result == InterstitialAdResult.LOADED) {
            if (isLoader) {
              Get.back();
            }
            onLoad.call();
            FacebookInterstitialAd.showInterstitialAd();
          }

          if (result == InterstitialAdResult.ERROR) {
            onFailed.call();
          }

          if (result == InterstitialAdResult.DISMISSED) {
            onDismissed.call();
          }
        },
      );
    } else {
      onDismissed.call();
    }
  }

  static Future<void>? nativeSmallAd(
      String adId, Function callBackLoad, Function onFailed) {
    NativeAd(
      adUnitId: adId,
      factoryId: 'listTileSmall',
      request: const AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          var add = ad as NativeAd;
          Debug.printLog(
              "**** AD NativeInlinePageSmallListData ***** ${add.responseInfo}");
          callBackLoad.call(add);
          // callBack.call();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          callBackLoad.call(null);
          Debug.printLog(
              ' **** AD NativeInlinePageSmallListData *****  Ad load failed (code=${error.code} message=${error.message})');
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
    ).load();
    return null;
  }

  static Future<void>? normalNativeAd(
      String adId, Function callBackLoad, Function onFailed) {
    NativeAd(
      adUnitId: adId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          var add = ad as NativeAd;
          Debug.printLog(
              "**** AD NativeInlinePageSmallListData ***** ${add.responseInfo}");
          callBackLoad.call(add);
          // callBack.call();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          callBackLoad.call(null);
          Debug.printLog(
              ' **** AD NativeInlinePageSmallListData *****  Ad load failed (code=${error.code} message=${error.message})');
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
    ).load();
    return null;
  }

  static nativeGoogleAd(Function callBack) {
    NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTileSmall',
      request: const AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          var add = ad as NativeAd;
          Debug.printLog(
              "**** AD NativeInlinePageSmallListData ***** ${add.responseInfo}");
          callBack.call(add);
          // callBack.call();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          callBack.call(null);
          Debug.printLog(
              ' **** AD NativeInlinePageSmallListData *****  Ad load failed (code=${error.code} message=${error.message})');
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
    ).load();
  }

  static nativeNormalGoogleAd(Function callBack, {bool isAdFailed = false}) {
    NativeAd(
      adUnitId: (Debug.isAdxEnable)
          ? (isAdFailed)
              ? AdHelper.nativeAdUnitId
              : AdHelper.nativeAdUnitIdAdx
          : (isAdFailed)
              ? AdHelper.nativeAdUnitIdAdx
              : AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          var add = ad as NativeAd;
          Debug.printLog(
              "**** AD NativeInlinePageSmallListData ***** ${add.responseInfo}");
          callBack.call(add);
          // callBack.call();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          callBack.call(null);
          Debug.printLog(
              ' **** AD NativeInlinePageSmallListData *****  Ad load failed (code=${error.code} message=${error.message})');
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
    ).load();
  }

  static bool isFailed = false;

  static Widget? smallFacebookAd(Function onFailed) {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: const BoxDecoration(
          color: CColor.white,
          // borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        alignment: Alignment.center,
        height: 200,
        child: FacebookNativeAd(
          placementId: AdHelper.nativeAdUnitIdFacebook,
          adType: NativeAdType.NATIVE_AD,
          backgroundColor: Colors.white,
          titleColor: Colors.black,
          descriptionColor: Colors.black,
          buttonColor: CColor.black12,
          buttonTitleColor: Colors.white,
          buttonBorderColor: Colors.black,
          isMediaCover: false,
          listener: (result, value) {
            if (result == NativeAdResult.ERROR) {
              Constant.adGoogle = true;
              onFailed.call(true);
            } else if (result == NativeAdResult.LOADED) {
              isFailed = false;
              Constant.adGoogle = false;
              onFailed.call(false);
              Constant.isFacebookAd = false;
            }

            Debug.printLog("Native Ad: $result --> $value");
          },
          keepExpandedWhileLoading: true,
          expandAnimationDuraion: 1000,
        ),
      ),
    );
  }

  static Widget? normalFacebookAd(Function onFailed) {
    return (isFailed)
        ? Container()
        : ClipRRect(
            child: Container(
              decoration: const BoxDecoration(
                color: CColor.white,
              ),
              width: double.infinity,
              alignment: Alignment.center,
              height: 300,
              child: FacebookNativeAd(
                placementId: AdHelper.nativeAdUnitIdFacebook,
                adType: NativeAdType.NATIVE_AD,
                backgroundColor: Colors.white,
                titleColor: Colors.black,
                descriptionColor: Colors.black,
                buttonColor: CColor.black12,
                buttonTitleColor: Colors.white,
                buttonBorderColor: Colors.black,
                isMediaCover: false,
                listener: (result, value) {
                  if (result == NativeAdResult.ERROR) {
                    onFailed.call();
                    isFailed = true;
                    smallFacebookAd(onFailed);
                  } else if (result == NativeAdResult.LOADED) {
                    isFailed = false;
                  }

                  Debug.printLog("Native Ad: $result --> $value");
                },
                keepExpandedWhileLoading: true,
                expandAnimationDuraion: 1000,
              ),
            ),
          );
  }

  static Widget? smallNativeAd(NativeAd? homeAd) {
    return Container(
        child: (homeAd != null)
            ? Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CColor.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 200,
                margin: EdgeInsets.only(
                    top: Sizes.height_3,
                    right: Sizes.width_5,
                    bottom: Sizes.height_1_5,
                    left: Sizes.width_5),
                child: AdWidget(ad: homeAd),
              )
            : Container());
  }

  static Widget? sliderSmallNativeAd(NativeAd? homeAd) {
    return Container(
        child: (homeAd != null)
            ? Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CColor.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 200,
                margin: EdgeInsets.only(
                    top: Sizes.height_3,
                    right: Sizes.width_5,
                    bottom: Sizes.height_1_5,
                    left: Sizes.width_5),
                child: AdWidget(ad: homeAd),
              )
            : Container());
  }

  static Widget? smallNativeWithoutMarginAd(NativeAd? homeAd) {
    return Container(
        child: (homeAd != null)
            ? Container(
                decoration: const BoxDecoration(
                  color: CColor.white,
                ),
                width: double.infinity,
                alignment: Alignment.center,
                height: 200,
                child: AdWidget(ad: homeAd),
              )
            : Container());
  }

  static Widget? nativeNormalAd(NativeAd? homeAd) {
    return Container(
        child: (homeAd != null)
            ? Container(
                decoration: const BoxDecoration(
                  color: CColor.white,
                  // borderRadius: BorderRadius.circular(15),
                ),
                width: double.infinity,
                alignment: Alignment.center,
                height: 400,
                child: AdWidget(ad: homeAd),
              )
            : Container()
        // : smallNativeAdFacebook(Get.context!, isDarkMode),
        );
  }

  static Future<void>? bottomSheetAd(
      String adId, Function callBackLoad, Function onFailed) {
    NativeAd(
      adUnitId: adId,
      factoryId: 'listTileNativeAdBottomSheet',
      request: const AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          var add = ad as NativeAd;
          callBackLoad.call(add);
          Debug.printLog(
              "**** AD Native banner light***** ${add.responseInfo}");
          // _generateRandomString();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          callBackLoad.call(null);
          onFailed.call();
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
    ).load();
    return null;
  }

  static Widget? bottomSheetBannerAd(NativeAd? homeAd) {
    return (homeAd != null)
        ? Container(
            height: 70.0,
            alignment: Alignment.center,
            child: AdWidget(ad: homeAd),
          )
        : Container();
  }

  static Widget? bottomSheetBannerFacebookAd(NativeAd? homeAd) {
    return (homeAd != null)
        ? Container(
            height: 70.0,
            alignment: Alignment.center,
            child: AdWidget(ad: homeAd),
          )
        : Container();
  }

  static Future<void>? generateRandomString() async {
    const platform = MethodChannel('nativeAdChannel');
    try {
      await platform.invokeMethod('nativeAdFromBanner', {});
    } on PlatformException catch (e) {
      Debug.printLog("error on method channel.......${e.message}");
    }
  }
}
