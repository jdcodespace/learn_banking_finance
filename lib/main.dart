import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_banking_finance/connectivitymanager/connectivitymanager.dart';
import 'package:learn_banking_finance/datamodel/bank_data.dart';
import 'package:learn_banking_finance/google_ads/ad_helper.dart';
import 'package:learn_banking_finance/google_ads/app_open.dart';
import 'package:learn_banking_finance/google_ads/inter/interAd.dart';
import 'package:learn_banking_finance/localization/locale_constant.dart';
import 'package:learn_banking_finance/routes/app_pages.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/themes/app_theme.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/constant.dart';
import 'package:learn_banking_finance/utils/debug.dart';
import 'package:learn_banking_finance/utils/preference.dart';
import 'localization/localizations_delegate.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preference().instance();
  await InternetConnectivity().instance();

  await getFirebaseData();

  await Future.delayed(const Duration(milliseconds: 3000));

  runApp(
    const MyApp(),
  );
}

/*Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}*/

Future<void> getFirebaseData() async {
  FirebaseDatabase.instance.reference().once().then((value) {
    var categoriesData = value.snapshot.value as Map;
    if (categoriesData["data"] != null) {
      Constant.firebaseBankData = BankData.fromJson(categoriesData);
      Debug.printLog(
          "Constant.firebaseBankData....................${Constant.firebaseBankData.data!.accounting!.length}   ${Constant.firebaseBankData.data!.accounting!.length}  ");
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
      }
      if (key == Debug.keyNameAdTypeGoogle) {
        if (value["banner"]["Banner_Google_Property_Type_Child"] != null) {
          Debug.googleBanner =
              value["banner"]["Banner_Google_Property_Type_Child"];
        }

        if (value["inter"]["Interstitial_Google_Property_Type_Child"] != null) {
          Debug.googleInterstitial =
              value["inter"]["Interstitial_Google_Property_Type_Child"];
        }

        if (value["openApp"]["adAOKEY"] != null) {
          Debug.googleOpenApp = value["openApp"]["adAOKEY"];
        }

        if (value["native"]["Native_Google_Property_Type_Child"] != null) {
          Debug.googleNative =
              value["native"]["Native_Google_Property_Type_Child"];
        }
      }
      if (key == Debug.keyNameAdTypeFaceBook) {
        if (value["inter"]["Interstitial_FB_Property_Type_Child"] != null) {
          Debug.facebookInterstitial =
              value["inter"]["Interstitial_FB_Property_Type_Child"];
        }

        if (value["native"]["Native_FB_Property_Type_Child"] != null) {
          Debug.facebookNative =
              value["native"]["Native_FB_Property_Type_Child"];
        }
      }
    });
  });
}

preloadAllNativeAds(BuildContext context) async {
  var brightness = SchedulerBinding.instance.window.platformBrightness;
  bool isDarkMode = brightness == Brightness.dark;
  Debug.printLog("night or light mode.......$isDarkMode");

  /*native banner*/
  Debug.preloadNativeBanner = NativeAd(
    adUnitId: AdHelper.nativeAdUnitId,
    factoryId: 'listTileBanner',
    request: const AdRequest(),
    listener: NativeAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) {
        Debug.printLog('Ad load success preload.......');
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
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
  );
  Debug.preloadNativeBanner!.load();

  /*native normal*/
  Debug.preloadNativeNormal = NativeAd(
    adUnitId: AdHelper.nativeAdUnitId,
    factoryId: 'listTile',
    request: const AdRequest(),
    listener: NativeAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) {
        var add = ad as NativeAd;
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
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
  Debug.preloadNativeNormal!.load();

  /*native small*/
  Debug.preloadNativeSmall = NativeAd(
    adUnitId: AdHelper.nativeAdUnitId,
    factoryId: 'listTileSmall',
    request: const AdRequest(),
    listener: NativeAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) {
        var add = ad as NativeAd;
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
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
  Debug.preloadNativeSmall!.load();
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
    if (Debug.isShowAd && Debug.isNativeAd) {
      preloadAllNativeAds(context);
    }

    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor = AppLifecycleReactor(
      appOpenAdManager: appOpenAdManager,
    );
    _appLifecycleReactor.listenToAppStateChanges();
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
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn Banking Finance',
      color: CColor.white,
      translations: AppLanguages(),
      fallbackLocale: const Locale(Constant.languageEn, Constant.countryCodeEn),
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      locale: Get.deviceLocale,
      getPages: AppPages.list,
      initialRoute: AppRoutes.home,
    );
  }
}
