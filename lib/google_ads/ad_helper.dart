

import '../utils/debug.dart';

class AdHelper {

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

  static String get nativeAdUnitIdBannerFacebook {
    if (Debug.isShowAd) {
      return Debug.facebookNativeBanner;
    } else {
      return "";
    }
  }
}
