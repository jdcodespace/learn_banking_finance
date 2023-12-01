// ignore_for_file: deprecated_member_use
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learn_banking_finance/ad_mediation/ad_mediation.dart';
import 'package:learn_banking_finance/connectivitymanager/connectivitymanager.dart';
import 'package:learn_banking_finance/datamodel/bank_data.dart';
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
  if(Debug.isShowAd && Debug.isShowInter) {
    AdMediation.splashInterMediation(() {
      runApp(const MyApp());
    });
  }else{
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

  await FirebaseDatabase.instance.ref("adsBool").once().then((value) {
    Map dataAds = value.snapshot.value as Map;
    Debug.isShowAd = dataAds[Debug.keyNameIsShowAd];
    Debug.isShowBanner = dataAds[Debug.keyNameIsShowBanner];
    Debug.isShowRewarded = dataAds[Debug.keyNameIsShowRewarded];
    Debug.isShowOpenAd = dataAds[Debug.keyNameIsShowOpenAd];
    Debug.isShowInter = dataAds[Debug.keyNameIsShowInter];
    Debug.isNativeAd = dataAds[Debug.keyNameIsNativeAd];
  });

  await FirebaseDatabase.instance.ref("customAds").once().then((value) {
    Map dataAds = value.snapshot.value as Map;

    Debug.adType = dataAds[Debug.keyNameAdType];
    Debug.isAdxEnable = dataAds[Debug.keyNameIsAdxEnable];

    /*Adx Data*/
    Debug.googleAdxBanner =
    dataAds[Debug.keyNameIsAdx]["banner"]["Banner_Google_Adx_Ad"];
    Debug.googleAdxInterstitial =
    dataAds[Debug.keyNameIsAdx]["inter"]["Interstitial_Google_Adx_Ad"];
    Debug.googleAdxOpenApp =
    dataAds[Debug.keyNameIsAdx]["openApp"]["ad_AppOpen_Adx_Ad"];
    Debug.googleAdxNative =
    dataAds[Debug.keyNameIsAdx]["native"]["Native_Google_Adx_Ad"];

    /*Facebook Data*/
    Debug.facebookInterstitial =
    dataAds[Debug.keyNameAdTypeFaceBook]["inter"]["Interstitial_FB_Ad"];
    Debug.facebookNative =
    dataAds[Debug.keyNameAdTypeFaceBook]["native"]["Native_FB_Ad"];
    Debug.facebookNativeSmall =
    dataAds[Debug.keyNameAdTypeFaceBook]["nativeSmall"]["Small_Native_Ad"];

    /*Google data*/
    Debug.googleBanner =
    dataAds[Debug.keyNameAdTypeGoogle]["banner"]["Banner_Google_Ad"];
    Debug.googleInterstitial =
    dataAds[Debug.keyNameAdTypeGoogle]["inter"]["Interstitial_Google_Ad"];
    Debug.googleOpenApp =
    dataAds[Debug.keyNameAdTypeGoogle]["openApp"]["ad_AppOpen_Ad"];
    Debug.googleNative =
    dataAds[Debug.keyNameAdTypeGoogle]["native"]["Native_Google_Ad"];
  });

  await FirebaseDatabase.instance.ref("other").once().then((value) {
    Map dataAds = value.snapshot.value as Map;
    Preference.currentAdCount = dataAds[Debug.keyNameCurrentAdCount];
    Debug.totalAdInterCount = dataAds[Debug.keyNameTotalAdInterCount];
    Debug.privacyPolicy = dataAds[Debug.keyPrivacyPolicy];
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
      transitionDuration: const Duration(milliseconds: 50),
    );
  }
}
