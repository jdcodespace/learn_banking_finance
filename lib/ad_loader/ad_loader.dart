import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../dialog/progressdialog.dart';
import '../google_ads/ad_helper.dart';
import '../utils/constant.dart';
import '../utils/debug.dart';
import '../utils/preference.dart';

class AdLoader {
  static int index = 1;
  static bool isLoader = false;

  static interAdGoogle(
      Function onDismissed, Function onFailed, Function onAdLoad) {
    if (Debug.isShowAd && Debug.isShowInter) {
      if (Constant.interGoogleAd != null) {
          Constant.interGoogleAd!.show();
          Debug.printLog(":::::::::: google ad show :::::::::: $index");
          Constant.interGoogleAd!.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
                Constant.interGoogleAd = null;
                Constant.isAdGoogleLoader = true;
                index++;
                AdLoader.interAdGoogle(() {}, () {}, () {});
                onDismissed.call();
              });

        onAdLoad.call();
      } else {
        if(!isLoader){
          if (!Constant.isAdGoogleLoader) {
            try {
              showDialog(
                  context: Get.context!,
                  barrierDismissible: false,
                  builder: (context) {
                    return WillPopScope(
                      onWillPop: ()async{
                        return false;
                      },
                      child: ProgressLoadingDialog(
                          inAsyncCall: true, child: Container()),
                    );
                  });
            } catch (e) {
              Debug.printLog(e.toString());
              Get.back();
            }
          }
        }
        Debug.printLog(":::::::::: google ad request :::::::::: $index");
        InterstitialAd.load(
          adUnitId: AdHelper.interstitialAdUnitId,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              Debug.printLog(":::::::::: google ad load :::::::::: $index");
              if (!Constant.isAdGoogleLoader) {

                ad.show();
                Debug.printLog(":::::::::: google ad show :::::::::: $index");
              }
              onAdLoad.call();
              Constant.interGoogleAd = ad;
              ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  Constant.interGoogleAd = null;
                  Constant.isAdGoogleLoader = true;
                  index++;
                  AdLoader.interAdGoogle(() {}, () {}, () {});
                  onDismissed.call(ad);
                },
              );
            },
            onAdFailedToLoad: (err) {
              Constant.isAdGoogleLoader = true;
              isLoader = true;
              Debug.printLog(":::::::::: google ad fail :::::::::: $index");
              onFailed.call();
            },
          ),
        );
      }
    }
  }

  static interAdGoogleAdx(
      Function onDismissed, Function onFailed, Function onAdLoad) {
    if (Debug.isShowAd && Debug.isShowInter) {
      if (Constant.interGoogleAdxAd != null) {
          Constant.interGoogleAdxAd!.show();
          Debug.printLog(":::::::::: google adx show :::::::::: $index");
          Constant.interGoogleAdxAd!.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
                Constant.interGoogleAdxAd = null;
                Constant.isAdxAdLoader = true;
                index++;
                AdLoader.interAdGoogleAdx(() {}, () {}, () {});
                onDismissed.call(ad);
        });

        onAdLoad.call();
      } else {
        if(!isLoader) {
          if (!Constant.isAdxAdLoader) {
            try {
              showDialog(
                  context: Get.context!,
                  barrierDismissible: false,
                  builder: (context) {
                    return WillPopScope(
                      onWillPop: ()async{
                        return false;
                      },
                      child: ProgressLoadingDialog(
                          inAsyncCall: true, child: Container()),
                    );
                  });
            } catch (e) {
              Debug.printLog(e.toString());
              Get.back();
            }
          }
        }
        Debug.printLog(":::::::::: google adx request :::::::::: $index");
        InterstitialAd.load(
          adUnitId: AdHelper.interAdUnitIdAdx,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              Debug.printLog(":::::::::: google adx load :::::::::: $index");
              if (!Constant.isAdxAdLoader) {
                ad.show();
                Debug.printLog(":::::::::: google adx show :::::::::: $index");
              }
              onAdLoad.call();
              Constant.interGoogleAdxAd = ad;
              ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  Constant.interGoogleAdxAd = null;
                  Constant.isAdxAdLoader = true;
                  index++;
                  AdLoader.interAdGoogleAdx(() {}, () {}, () {});
                  onDismissed.call(ad);
                },
              );
            },
            onAdFailedToLoad: (err) {
              Constant.isAdxAdLoader = true;
              isLoader = true;
              Debug.printLog(":::::::::: google adx fail :::::::::: $index");
              onFailed.call();
            },
          ),
        );
      }
    }
  }

  static interAdFacebook(
      Function onDismissed, Function onFailed, Function onAdLoad) {
    if(!isLoader){
      if (!Constant.isFacebookAdLoader) {
        try {
          showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (context) {
                return WillPopScope(
                  onWillPop: ()async{
                    return false;
                  },
                  child: ProgressLoadingDialog(
                      inAsyncCall: true, child: Container()),
                );
              });
        } catch (e) {
          Debug.printLog(e.toString());
          Get.back();
        }
      }
    }
    if (Constant.isFacebookAdLoader) {
        FacebookInterstitialAd.showInterstitialAd().then((value) {
          onAdLoad.call();
          Debug.printLog(":::::::::: facebook ad show :::::::::: $index");
        });
      FacebookInterstitialAd.loadInterstitialAd(
        placementId: AdHelper.interstitialAdUnitIdFacebook,
        listener: (result, value) {
          if (result == InterstitialAdResult.LOADED) {
            // onAdLoad.call();
            Debug.printLog(":::::::::: facebook ad load :::::::::: $index");
          }
          if (result == InterstitialAdResult.ERROR) {
            Constant.isFacebookAdLoader = true;
            isLoader = true;
            Debug.printLog(":::::::::: facebook ad fail :::::::::: $index");
            onFailed.call();

          }

          if (result == InterstitialAdResult.DISMISSED) {
            onDismissed.call();
            index++;
            Constant.isFacebookAdLoader = true;

            interAdFacebook(() {}, () {}, () {});
          }
        },
      );
    } else {
      Debug.printLog(":::::::::: facebook ad request :::::::::: $index");
      FacebookInterstitialAd.loadInterstitialAd(
        placementId:AdHelper.interstitialAdUnitIdFacebook,
        listener: (result, value) {
          if (result == InterstitialAdResult.LOADED) {
            Debug.printLog(":::::::::: facebook ad load :::::::::: $index");
            if (!Constant.isFacebookAdLoader) {
              FacebookInterstitialAd.showInterstitialAd();
              Debug.printLog(":::::::::: facebook ad show :::::::::: $index");
            }
            onAdLoad.call();
          }
          if (result == InterstitialAdResult.ERROR) {
            Constant.isFacebookAdLoader = true;
            isLoader = true;
            Debug.printLog(":::::::::: facebook ad fail :::::::::: $index");
            onFailed.call();
          }

          if (result == InterstitialAdResult.DISMISSED) {
            onDismissed.call();
            index++;

            Constant.isFacebookAdLoader = true;
            FacebookInterstitialAd.destroyInterstitialAd();
            interAdFacebook(() {}, () {}, () {});
            Debug.printLog(":::::::::: facebook ad request :::::::::: $index");
          }
        },
      );
    }
  }

  static interAdCountGoogle(
      Function onDismissed, Function onFailed, Function onAdLoad) {
    if (Debug.isShowAd && Debug.isShowInter && Debug.totalAdInterCount <= Preference.currentAdCount) {
      if (Constant.interGoogleAdxAd != null) {
        Constant.interGoogleAdxAd!.show();
        Debug.printLog(":::::::::: google ad show :::::::::: $index");
        Constant.interGoogleAdxAd!.fullScreenContentCallback =
            FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              Constant.interGoogleAdxAd = null;
              Constant.isAdxAdLoader = true;
              index++;
              Preference.currentAdCount = 1;
              AdLoader.interAdGoogleAdx(() {}, () {}, () {});
              onDismissed.call(ad);
            });
        onAdLoad.call();
      } else {
        if(!isLoader) {
          if (!Constant.isAdxAdLoader) {
            try {
              showDialog(
                  context: Get.context!,
                  barrierDismissible: false,
                  builder: (context) {
                    return WillPopScope(
                      onWillPop: ()async{
                        return false;
                      },
                      child: ProgressLoadingDialog(
                          inAsyncCall: true, child: Container()),
                    );
                  });
            } catch (e) {
              Debug.printLog(e.toString());
              Get.back();
            }
          }
        }
        Debug.printLog(":::::::::: google ad request :::::::::: $index");
        InterstitialAd.load(
          adUnitId: AdHelper.interstitialAdUnitId,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              Debug.printLog(":::::::::: google ad load :::::::::: $index");
              if (!Constant.isAdxAdLoader) {
                ad.show();
                Debug.printLog(":::::::::: google ad show :::::::::: $index");
              }
              onAdLoad.call();
              Constant.interGoogleAdxAd = ad;
              ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  Constant.interGoogleAdxAd = null;
                  Constant.isAdxAdLoader = true;
                  index++;
                  Preference.currentAdCount = 1;
                  AdLoader.interAdGoogleAdx(() {}, () {}, () {});
                  onDismissed.call(ad);
                },
              );
            },
            onAdFailedToLoad: (err) {
              Constant.isAdxAdLoader = true;
              isLoader = true;
              Debug.printLog(":::::::::: google ad fail :::::::::: $index");
              onFailed.call();
            },
          ),
        );
      }
    }else{
      Preference.currentAdCount++;
      onAdLoad.call();
    }
  }

  static interAdCountGoogleAdx(
      Function onDismissed, Function onFailed, Function onAdLoad) {
    if (Debug.isShowAd && Debug.isShowInter && Debug.totalAdInterCount <= Preference.currentAdCount) {
      if (Constant.interGoogleAdxAd != null) {
        Constant.interGoogleAdxAd!.show();
        Debug.printLog(":::::::::: google adx show :::::::::: $index");
        Constant.interGoogleAdxAd!.fullScreenContentCallback =
            FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              Constant.interGoogleAdxAd = null;
              Constant.isAdxAdLoader = true;
              index++;
              Preference.currentAdCount = 1;
              AdLoader.interAdGoogleAdx(() {}, () {}, () {});
              onDismissed.call(ad);
            });
        onAdLoad.call();
      } else {
        if(!isLoader) {
          if (!Constant.isAdxAdLoader) {
            try {
              showDialog(
                  context: Get.context!,
                  barrierDismissible: false,
                  builder: (context) {
                    return WillPopScope(
                      onWillPop: ()async{
                        return false;
                      },
                      child: ProgressLoadingDialog(
                          inAsyncCall: true, child: Container()),
                    );
                  });
            } catch (e) {
              Debug.printLog(e.toString());
              Get.back();
            }
          }
        }
        Debug.printLog(":::::::::: google adx request :::::::::: $index");
        InterstitialAd.load(
          adUnitId: AdHelper.interAdUnitIdAdx,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              Debug.printLog(":::::::::: google adx load :::::::::: $index");
              if (!Constant.isAdxAdLoader) {
                ad.show();
                Debug.printLog(":::::::::: google adx show :::::::::: $index");
              }
              onAdLoad.call();
              Constant.interGoogleAdxAd = ad;
              ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  Constant.interGoogleAdxAd = null;
                  Constant.isAdxAdLoader = true;
                  index++;
                  AdLoader.interAdGoogleAdx(() {}, () {}, () {});
                  Preference.currentAdCount = 1;
                  onDismissed.call(ad);
                },
              );
            },
            onAdFailedToLoad: (err) {
              Constant.isAdxAdLoader = true;
              isLoader = true;
              Debug.printLog(":::::::::: google adx fail :::::::::: $index");
              onFailed.call();
            },
          ),
        );
      }
    }else{
      Preference.currentAdCount++;
      onDismissed.call();
    }
  }


  static interAdCountFacebook(
      Function onDismissed, Function onFailed, Function onAdLoad) {
    if(Debug.totalAdInterCount <= Preference.currentAdCount) {
      if (!isLoader) {
        if (!Constant.isFacebookAdLoader) {
          try {
            showDialog(
                context: Get.context!,
                barrierDismissible: false,
                builder: (context) {
                  return WillPopScope(
                    onWillPop: () async {
                      return false;
                    },
                    child: ProgressLoadingDialog(
                        inAsyncCall: true, child: Container()),
                  );
                });
          } catch (e) {
            Debug.printLog(e.toString());
            Get.back();
          }
        }
      }
      if (Constant.isFacebookAdLoader) {
        FacebookInterstitialAd.showInterstitialAd().then((value) {
          onAdLoad.call();
          Debug.printLog(":::::::::: facebook ad show :::::::::: $index");
        });
        FacebookInterstitialAd.loadInterstitialAd(
          placementId: AdHelper.interstitialAdUnitIdFacebook,
          listener: (result, value) {
            if (result == InterstitialAdResult.LOADED) {
              // onAdLoad.call();
              Debug.printLog(":::::::::: facebook ad load :::::::::: $index");
            }
            if (result == InterstitialAdResult.ERROR) {
              Constant.isFacebookAdLoader = true;
              isLoader = true;
              Debug.printLog(":::::::::: facebook ad fail :::::::::: $index");
              onFailed.call();
            }

            if (result == InterstitialAdResult.DISMISSED) {

              onDismissed.call();
              index++;
              Constant.isFacebookAdLoader = true;
              Preference.currentAdCount = 1;
              interAdFacebook(() {}, () {}, () {});
            }
          },
        );
      } else {
        Debug.printLog(":::::::::: facebook ad request :::::::::: $index");
        FacebookInterstitialAd.loadInterstitialAd(
          placementId: AdHelper.interstitialAdUnitIdFacebook,
          listener: (result, value) {
            if (result == InterstitialAdResult.LOADED) {
              Debug.printLog(":::::::::: facebook ad load :::::::::: $index");
              if (!Constant.isFacebookAdLoader) {
                FacebookInterstitialAd.showInterstitialAd();
                Debug.printLog(":::::::::: facebook ad show :::::::::: $index");
              }
              onAdLoad.call();
            }
            if (result == InterstitialAdResult.ERROR) {
              Constant.isFacebookAdLoader = true;
              isLoader = true;
              Debug.printLog(":::::::::: facebook ad fail :::::::::: $index");
              onFailed.call();
            }

            if (result == InterstitialAdResult.DISMISSED) {
              onDismissed.call();
              index++;
              Preference.currentAdCount = 1;
              Constant.isFacebookAdLoader = true;
              FacebookInterstitialAd.destroyInterstitialAd();
              interAdFacebook(() {}, () {}, () {});
              Debug.printLog(
                  ":::::::::: facebook ad request :::::::::: $index");
            }
          },
        );
      }
    }else{
      Preference.currentAdCount++;
      onDismissed.call();
    }
  }

}
