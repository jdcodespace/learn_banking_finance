// // ignore_for_file: non_constant_identifier_names
//
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:property_info_app/utils/debugs.dart';
// import '../ad_helper.dart';
//
// class AppOpenSplash{
//
//   static AppOpenAd? _appOpenAd;
//
//   static AppOpenSplash_Ad({required Function callBack}) {
//       loadAdmobAds(callBack);
//   }
//
//   static loadAdmobAds(Function callBack) {
//     Debug.printLog("loadAdmobAds==>> ");
//     AppOpenAd.load(
//       adUnitId:AdHelper.openAppAdUnitId ,
//       orientation: AppOpenAd.orientationPortrait,
//       request: const AdRequest(),
//       adLoadCallback: AppOpenAdLoadCallback(
//         onAdLoaded: (ad) {
//           debugPrint('$ad loaded');
//           _appOpenAd = ad;
//           _appOpenAd!.show();
//           _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
//             onAdShowedFullScreenContent: (ad) {
//               debugPrint('$ad onAdShowedFullScreenContent');
//             },
//             onAdFailedToShowFullScreenContent: (ad, error) {
//               debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
//               ad.dispose();
//               _appOpenAd = null;
//             },
//             onAdDismissedFullScreenContent: (ad) {
//               callBack();
//               debugPrint('$ad onAdDismissedFullScreenContent');
//               ad.dispose();
//               _appOpenAd = null;
//             },
//           );
//         },
//         onAdFailedToLoad: (error) {
//           callBack();
//         },
//       ),
//     );
//   }
//
// }