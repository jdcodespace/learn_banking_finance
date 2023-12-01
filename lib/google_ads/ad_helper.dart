import '../utils/debug.dart';

class AdHelper{
  /*Google*/
  static String get bannerAdUnitId {
    if (Debug.isShowAd) {
      return Debug.googleBanner;
    } else {
      return "";
    }
  }

  static String get interstitialAdUnitId {
    if (Debug.isShowAd) {
      return Debug.googleInterstitial;
    } else {
      return "";
    }
  }

  static String get rewardedAdUnitId {
    if (Debug.isShowAd) {
      return Debug.googleRewarded;
    } else {
      return "";
    }
  }

  static String get openAppAdUnitId {
    if (Debug.isShowAd) {
      return Debug.googleOpenApp;
    } else {
      return "";
    }
  }

  static String get nativeAdUnitId {
    if (Debug.isShowAd) {
      return Debug.googleNative;
    } else {
      return "";
    }
  }

  /*GoogleAdx*/
  static String get bannerAdUnitIdAdx {
    if (Debug.isShowAd) {
      return Debug.googleAdxBanner;
    } else {
      return "";
    }
  }

  static String get nativeAdUnitIdAdx {
    if (Debug.isShowAd) {
      return Debug.googleAdxNative;
    } else {
      return "";
    }
  }

  static String get interAdUnitIdAdx {
    if (Debug.isShowAd) {
      return Debug.googleAdxInterstitial;
    } else {
      return "";
    }
  }

  static String get appOpenAdUnitIdAdx {
    if (Debug.isShowAd) {
      return Debug.googleAdxOpenApp;
    } else {
      return "";
    }
  }

  static String get rewardedAdUnitIdAdx {
    if (Debug.isShowAd) {
      return Debug.googleAdxRewarded;
    } else {
      return "";
    }
  }

  /*Facebook*/
  static String get bannerAdUnitIdFacebook {
    if (Debug.isShowAd) {
      return Debug.facebookBanner;
    } else {
      return "";
    }
  }

  static String get interstitialAdUnitIdFacebook {
    if (Debug.isShowAd) {
      return Debug.facebookInterstitial;
    } else {
      return "";
    }
  }

  static String get rewardedAdUnitIdFacebook {
    if (Debug.isShowAd) {
      return Debug.facebookRewarded;
    } else {
      return "";
    }
  }

  static String get nativeAdUnitIdFacebookSmall {
    if (Debug.isShowAd) {
      return Debug.facebookNativeSmall;
    } else {
      return "";
    }
  }

  static String get nativeAdUnitIdFacebook {
    if (Debug.isShowAd) {
      return Debug.facebookNative;
    } else {
      return "";
    }
  }
}
