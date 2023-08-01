// ignore_for_file: deprecated_member_use

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learn_banking_finance/connectivitymanager/connectivitymanager.dart';
import 'package:learn_banking_finance/datamodel/bank_data.dart';
import 'package:learn_banking_finance/facebook_ads/inter/inter_ad.dart';
import 'package:learn_banking_finance/google_ads/inter/inter_ad.dart';
import 'package:learn_banking_finance/localization/locale_constant.dart';
import 'package:learn_banking_finance/routes/app_pages.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/constant.dart';
import 'package:learn_banking_finance/utils/debug.dart';
import 'package:learn_banking_finance/utils/preference.dart';
import 'google_ads/app_open/app_lifecycle.dart';
import 'localization/localizations_delegate.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preference().instance();
  await InternetConnectivity().instance();
  await getFirebaseData();
  await Future.delayed(const Duration(seconds: 1));
  // AdSettings.addTestDevice("e100eec6-0942-4c87-bee9-a6d1b327fbbf");

  if (Debug.adType == Debug.adGoogleType &&
      Debug.googleInterstitial.isNotEmpty &&
      Debug.isShowAd) {
    InterstitialAdClass.showInterstitialAdForSplash(() {
      runApp(
        const MyApp(),
      );
    });
  } else if (Debug.adType == Debug.adFacebookType &&
      Debug.facebookInterstitial.isNotEmpty &&
      Debug.isShowAd) {
    InterstitialFacebookAdClass.showInterstitialFacebookAdForSplash(() {
      runApp(
        const MyApp(),
      );
    });
  } else {
    runApp(const MyApp());
  }
}

Future<void> getFirebaseData() async {
  await FirebaseDatabase.instance.reference().once().then((value) {
    var categoriesData = value.snapshot.value as Map;
    if (categoriesData["data"] != null) {
      Constant.firebaseBankData = BankData.fromJson(categoriesData);
      Debug.printLog(
          "Constant.firebaseBankData....................${Constant.firebaseBankData.data!.accounting!.length} && ${Constant.firebaseBankData.data!.accounting!.length}");
    }
  });

  FirebaseDatabase.instance.ref("adsBool").onValue.listen((event) {
    final data = Map<String, dynamic>.from(
      event.snapshot.value as Map,
    );
    data.forEach((key, value) {
      Debug.printLog("$key $value");
      if (key == Debug.keyNameIsShowAd) {
        Debug.isShowAd = value;
        // Debug.isShowAd = false;
      }

      if (key == Debug.keyNameIsShowBanner) {
        Debug.isShowBanner = value;
      }

      if (key == Debug.keyNameIsShowRewarded) {
        Debug.isShowRewarded = value;
      }

      if (key == Debug.keyNameIsShowOpenAd) {
        Debug.isShowOpenAd = value;
      }

      if (key == Debug.keyNameIsShowInter) {
        Debug.isShowInter = value;
      }

      if (key == Debug.keyNameIsNativeAd) {
        Debug.isNativeAd = value;
      }

      if (key == Debug.keyNameIsBoostAd) {
        Debug.isBoostAd = value;
      }

      if (key == Debug.keyNameIsBuySellAd) {
        Debug.isBuySellAd = value;
      }
    });
  });
  FirebaseDatabase.instance.ref("customAds").onValue.listen((event) {
    final data = Map<String, dynamic>.from(event.snapshot.value as Map);
    data.forEach((key, value) {
      Debug.printLog("$key $value");
      if (key == Debug.keyNameAdType) {
        Debug.adType = value;
        // Debug.adType = "g";
      }
      if (key == Debug.keyNameAdTypeGoogle) {
        if (value["banner"]["Banner_Google_Property_Type_Child"] != null) {
          Debug.googleBanner =
              value["banner"]["Banner_Google_Property_Type_Child"];
        }

        if (value["inter"]["Interstitial_Google_Property_Type_Child"] != null) {
          Debug.googleInterstitial =
              /*"ca-app-pub-3940256099942544/1033173712";*/
              value["inter"]["Interstitial_Google_Property_Type_Child"];
        }

        if (value["openApp"]["adAOKEY"] != null) {
          Debug.googleOpenApp = value["openApp"]["adAOKEY"];
        }

        if (value["native"]["Native_Google_Property_Type_Child"] != null) {
          Debug.googleNative = /* "ca-app-pub-3940256099942544/2247696110";*/
              value["native"]["Native_Google_Property_Type_Child"];
        }
      }
      if (key == Debug.keyNameAdTypeFaceBook) {
        if (value["inter"]["Interstitial_FB_Property_Type_Child"] != null) {
          Debug.facebookInterstitial =
              /*"IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID";*/
              value["inter"]["Interstitial_FB_Property_Type_Child"];
        }

        if (value["native"]["Native_FB_Property_Type_Child"] != null) {
          Debug.facebookNative =
              /*"IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512";*/
              value["native"]["Native_FB_Property_Type_Child"];
        }
        if (value["nativeSmall"]["Small_Native_Home_Screen"] != null) {
          Debug.facebookNativeSmall =
              /*"IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512";*/
              value["nativeSmall"]["Small_Native_Home_Screen"];
        }
        if (value["native"]["Native_Banner"] != null) {
          Debug.facebookNativeBanner = value["native"]["Native_Banner"];
        }
      }
    });
  });

  FirebaseDatabase.instance.ref("other").onValue.listen((event) {
    final data = Map<String, dynamic>.from(event.snapshot.value as Map);
    data.forEach((key, value) {
      if (key == Debug.keyNameCurrentAdCount) {
        Preference.currentAdCount = value;
      }
      if (key == Debug.keyNameTotalAdInterCount) {
        Debug.totalAdInterCount = value;
      }
      if (key == Debug.keyNameTotalAttemptCount) {
        Preference.totalAttemptCount = value;
      }
      if (key == Debug.keyNameTotalAttemptCountNative) {
        Preference.totalAttemptCountNative = value;
      }
      if (key == Debug.keyNameTotalAttemptCountRewarded) {
        Preference.totalAttemptCountRewarded = value;
      }
      if (key == Debug.keyPrivacyPolicy) {
        Debug.privacyPolicy = value;
      }
    });
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    if (Debug.isShowAd && Debug.isShowOpenAd) {
      AppOpenAdManager appOpenAdManager = AppOpenAdManager()..appOpenAds();
      _appLifecycleReactor =
          AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
      _appLifecycleReactor.listenToAppStateChanges();
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        Debug.printLog(
            "didChangeDependencies Preference Revoked===>>> ${locale.languageCode}");
        Get.updateLocale(locale);
        Debug.printLog(
            " didChangeDependencies GET LOCALE Revoked====>> ${Get.locale!.languageCode}");
      });
    });
    final accountingImage = Image.network(Constant
        .firebaseBankData.data!.accounting![0].detail![0].image
        .toString());
    final bankingImage = Image.network(
        Constant.firebaseBankData.data!.bank![0].detail![0].image.toString());
    final faqImage =
        Image.network(Constant.firebaseBankData.data!.faq![0].image.toString());
    final tipImage = Image.network(
        Constant.firebaseBankData.data!.tips![0].image.toString());
    final slider1Image = Image.network(
        Constant.firebaseBankData.data!.slider![0].image.toString());
    final slider2Image = Image.network(
        Constant.firebaseBankData.data!.slider![1].image.toString());
    precacheImage(accountingImage.image, context);
    precacheImage(bankingImage.image, context);
    precacheImage(faqImage.image, context);
    precacheImage(tipImage.image, context);
    precacheImage(slider1Image.image, context);
    precacheImage(slider2Image.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn Banking and Finance',
      color: CColor.white,
      translations: AppLanguages(),
      fallbackLocale: const Locale(Constant.languageEn, Constant.countryCodeEn),
      locale: Get.deviceLocale,
      getPages: AppPages.list,
      initialRoute: (Preference.shared.getBool(Preference.isLogin) == true)
          ? AppRoutes.home
          : AppRoutes.slider,
      // initialRoute:AppRoutes.slider,
      transitionDuration: const Duration(milliseconds: 50),
    );
  }
}
