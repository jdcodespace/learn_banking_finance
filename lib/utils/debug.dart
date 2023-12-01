import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class Debug {
  static const debug = true;
  static const sandboxApiUrl = true;
  static const sandboxVerifyReceiptUrl = false;

  static var isShowAd = true;
  static var isShowBanner = true;
  static var isShowRewarded = true;
  static var isShowOpenAd = true;
  static var isShowInter = true;
  static var isNativeAd = true;
  static var isBackAd = true;
  static var isAdxEnable = true;

  static NativeAd? preloadNativeBanner;
  static NativeAd? preloadNativeNormal;
  static NativeAd? preloadNativeSmall;
  static NativeAd? preloadNativeSmallHome;
  static NativeAd? preloadNativeSmallBanking;
  static NativeAd? preloadNativeSmallAccount;

  static var keyNameIsShowAd = "isShowAd";
  static var keyNameIsShowBanner = "isShowBanner";
  static var keyNameIsShowRewarded = "isShowRewarded";
  static var keyNameIsShowOpenAd = "isShowOpen";
  static var keyNameIsShowInter = "isShowInter";
  static var keyNameIsNativeAd = "isShowNative";
  static var keyNameIsBoostAd = "isBoostAd";
  static var keyNameIsBuySellAd = "isBuySellAd";
  static var keyNameIsBackAd = "isBackAd";
  static var keyNameIsAdxEnable = "adxEnable";
  static var keyNameIsAdx = "ADX";

  static var fullAdCount = 20;
  static var totalAdInterCount = 0;
  static var keyNameFullAdCount = "fullAdCount";
  static var keyNameTotalAttempt = "totalAttemptForAdLoad";

  static var versionCode = 0;
  static var isForceUpdate = false;
  static var keyNameVersionCode = "versionCode";
  static var keyNameIsForceUpdate = "isForceUpdate";

  static var googleBanner = "";
  static var googleInterstitial = "";
  static var googleRewarded = "";
  static var googleOpenApp = "";
  static var googleNative = "";

  static var googleAdxBanner = "";
  static var googleAdxInterstitial = "";
  static var googleAdxRewarded = "";
  static var googleAdxOpenApp = "";
  static var googleAdxNative = "";

  static var facebookBanner = "";
  static var facebookInterstitial = "";
  static var facebookRewarded = "";
  static var facebookOpenApp = "";
  static var facebookNative = "";
  static var facebookNativeSmall = "";
  static var facebookNativeBanner = "";

  static var adGoogleType = "g";
  static var adFacebookType = "f";
  static var adType = adGoogleType;


  static var keyPrivacyPolicy = "privacy";
  static var privacyPolicy = "";

  static var keyNameAdType = "adType";
  static var keyNameAdTypeGoogle = "google";
  static var keyNameAdTypeFaceBook = "facebook";
  static var keyNameGoogleBanner = "googleBanner";
  static var keyNameGoogleInterstitial = "googleInterstitial";
  static var keyNameGoogleRewarded = "googleRewarded";
  static var keyNameGoogleOpenApp = "googleOpenApp";
  static var keyNameGoogleNative = "googleNative";
  static var keyNameFacebookInter = "facebookInter";
  static var keyNameFacebookRewarded = "facebookRewarded";
  static var keyNameFacebookNative = "facebookNative";
  static var keyNameFacebookSmallNative = "facebookSmallNative";
  static var keyNameCurrentAdCount = "currentAdCount";
  static var keyNameTotalAdInterCount = "totalAdInterCount";
  static var keyNameTotalAdInterCountBack = "totalAdInterCountBack";
  static var keyNameTotalAdInterCountQuiz = "totalAdInterCountQuiz";
  static var keyNameTotalAdInterCountIdentify = "totalAdInterCountIdentify";
  static var keyNameTotalAttemptCount = "totalAttemptCount";
  static var keyNameTotalAttemptCountNative = "totalAttemptCountNative";
  static var keyNameTotalAttemptCountRewarded = "totalAttemptCountRewarded";

  static printLog(String str) {
    if (debug) log(str);
  }
}
