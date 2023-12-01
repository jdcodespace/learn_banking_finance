import 'package:learn_banking_finance/ad_mediation/ad_load.dart';
import '../google_ads/ad_helper.dart';
import '../utils/debug.dart';


class AdMediation {
  static splashInterMediation(Function onDismiss) {
    if (Debug.adType == Debug.adGoogleType) {
      if (Debug.isAdxEnable) {
        AdLoad.googleInter(
          AdHelper.interAdUnitIdAdx,
          isLoader: false,
          () {
            onDismiss.call();
          }, // ADX load
          () {
            AdLoad.googleInter(
              AdHelper.interstitialAdUnitId,
              isLoader: false,
              () {
                onDismiss.call();
              }, // Google load
              () {
                AdLoad.facebookInter(
                  AdHelper.interstitialAdUnitIdFacebook,
                  isLoader: false,
                  () {
                    onDismiss.call();
                  }, // Facebook load
                  () {}, // Facebook fail
                  () {}, // Facebook dismiss
                );
              }, // Google fail
              () {}, // Google dismiss
            );
          }, // ADX fail
          () {
            onDismiss.call();
          }, // ADX dismiss
        );
      } else {
        AdLoad.googleInter(
          AdHelper.interstitialAdUnitId,
          isLoader: false,
          () {
            onDismiss.call();
          }, // Google load
          () {
            AdLoad.googleInter(
              AdHelper.interAdUnitIdAdx,
              isLoader: false,
              () {
                onDismiss.call();
              }, // ADX load
              () {
                AdLoad.facebookInter(
                  AdHelper.interstitialAdUnitIdFacebook,
                  isLoader: false,
                  () {
                    onDismiss.call();
                  }, // Facebook load
                  () {
                    // onDismiss.call();
                  }, //Facebook fail
                  () {
                    // onDismiss.call();
                  }, // Facebook dismiss
                );
              }, // ADX fail
              () {
                // onDismiss.call();
              }, // ADX dismiss
            );
          }, // Google fail
          () {
            // onDismiss.call();
          }, // Google dismiss
        );
      }
    } else if (Debug.adType == Debug.adFacebookType) {
      AdLoad.facebookInter(
        AdHelper.interstitialAdUnitIdFacebook,
        isLoader: false,
        () {
          onDismiss.call();
        }, // Facebook load
        () {
          if (Debug.isAdxEnable) {
            AdLoad.googleInter(
              AdHelper.interAdUnitIdAdx,
              isLoader: false,
              () {
                onDismiss.call();
              }, // ADX load
              () {
                AdLoad.googleInter(
                  AdHelper.interstitialAdUnitId,
                  isLoader: false,
                  () {
                    onDismiss.call();
                  }, // Google load
                  () {
                    // onDismiss.call();
                  }, // Google fail
                  () {
                    // onDismiss.call();
                  }, // Google dismiss
                );
              }, // ADX fail
              () {
                // onDismiss.call();
              }, // ADX dismiss
            );
          } else {
            AdLoad.googleInter(
              AdHelper.interstitialAdUnitId,
              isLoader: false,
              () {
                onDismiss.call();
              }, // Google load
              () {
                AdLoad.googleInter(
                  AdHelper.interAdUnitIdAdx,
                  isLoader: false,
                  () {
                    onDismiss.call();
                  }, // ADX load
                  () {
                    onDismiss.call();
                  }, // ADX fail
                  () {
                    // onDismiss.call();
                  }, // ADX dismiss
                );
              }, // Google fail
              () {
                // onDismiss.call();
              }, // Google dismiss
            );
          }
        }, // Facebook fail
        () {
          // onDismiss.call();
        }, // Facebook dismiss
      );
    } else {
      onDismiss.call();
    }
  }

  static smallNativeMediation(Function adLoad, Function facebookAd) {
    // if (Debug.adType == Debug.adGoogleType) {
    if (Debug.isAdxEnable) {
      AdLoad.nativeSmallAd(AdHelper.nativeAdUnitIdAdx, (ad) {
        adLoad.call(ad);
      }, () {
        AdLoad.nativeSmallAd(AdHelper.nativeAdUnitId, (ad) {
          adLoad.call(ad);
        }, () {
          facebookAd.call(true);
        });
      });
    } else {
      AdLoad.nativeSmallAd(AdHelper.nativeAdUnitId, (ad) {
        adLoad.call(ad);
      }, () {
        AdLoad.nativeSmallAd(AdHelper.nativeAdUnitIdAdx, (ad) {
          adLoad.call(ad);
        }, () {
          facebookAd.call(true);
        });
      });
    }
    // }
  }

  static normalNativeMediation(Function adLoad, Function facebookAd) {
    if (Debug.adType == Debug.adGoogleType) {
      if (Debug.isAdxEnable) {
        AdLoad.normalNativeAd(AdHelper.nativeAdUnitIdAdx, (ad) {
          adLoad.call(ad);
        }, () {
          AdLoad.normalNativeAd(AdHelper.nativeAdUnitId, (ad) {
            adLoad.call(ad);
          }, () {
            facebookAd.call(true);
          });
        });
      } else {
        AdLoad.normalNativeAd(AdHelper.nativeAdUnitId, (ad) {
          adLoad.call(ad);
        }, () {
          AdLoad.normalNativeAd(AdHelper.nativeAdUnitIdAdx, (ad) {
            adLoad.call(ad);
          }, () {
            facebookAd.call(true);
          });
        });
      }
    }
  }

  static smallNativeFacebookMediation(Function adFailed) {
    // if (Debug.adType == Debug.adFacebookType) {
    AdLoad.smallFacebookAd((value) {
      if (Debug.isAdxEnable) {
        AdLoad.nativeSmallAd(AdHelper.nativeAdUnitIdAdx, (ad) {
          adFailed.call(ad);
        }, () {
          AdLoad.nativeSmallAd(AdHelper.nativeAdUnitId, (ad) {
            adFailed.call(ad);
          }, () {});
        });
      } else {
        AdLoad.nativeSmallAd(AdHelper.nativeAdUnitId, (ad) {
          adFailed.call(ad);
        }, () {
          AdLoad.nativeSmallAd(AdHelper.nativeAdUnitIdAdx, (ad) {
            adFailed.call(ad);
          }, () {});
        });
      }
    });
  }

  static bottomSheetMediation(Function adLoad, Function facebookAd) {
    if (Debug.adType == Debug.adGoogleType) {
      if (Debug.isAdxEnable) {
        AdLoad.bottomSheetAd(AdHelper.nativeAdUnitIdAdx, (ad) {
          adLoad.call(ad);
        }, () {
          AdLoad.bottomSheetAd(AdHelper.nativeAdUnitId, (ad) {
            adLoad.call(ad);
          }, () {
            facebookAd.call(true);
          });
        });
      } else {
        AdLoad.bottomSheetAd(AdHelper.nativeAdUnitId, (ad) {
          adLoad.call(ad);
        }, () {
          AdLoad.bottomSheetAd(AdHelper.nativeAdUnitIdAdx, (ad) {
            adLoad.call(ad);
          }, () {
            facebookAd.call(true);
          });
        });
      }
    }
  }
}
