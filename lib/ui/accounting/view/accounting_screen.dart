import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/ui/accounting/controller/accounting_controller.dart';
import 'package:learn_banking_finance/utils/utils.dart';
import '../../../ad_mediation/ad_load.dart';
import '../../../facebook_ads/inter/inter_ad.dart';
import '../../../google_ads/inter/inter_ad.dart';
import '../../../offline/offline_screen.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/debug.dart';
import '../../../utils/font.dart';
import '../../../utils/sizer_utils.dart';

class AccountingScreen extends StatelessWidget {
  const AccountingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingController>(builder: (logic) {
      return Scaffold(
        backgroundColor: CColor.white,
        body: SafeArea(
          child: logic.string == "Offline"
              ? OfflineScreen()
              : Column(
                  children: [
                    _appBar(logic, context),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _firstViewHeader(),
                            _widgetBlogNews(logic, context),
                            (Debug.isShowAd && Debug.isNativeAd)
                                ? Container(
                              child: (Debug.adType == Debug.adFacebookType)
                                  ? (Constant.adGoogle)
                                  ? AdLoad.sliderSmallNativeAd(logic.accountingAd)
                                  : AdLoad.smallFacebookAd(() {})
                                  : (Constant.isFacebookAd)
                                  ? AdLoad.smallFacebookAd(() {})
                                  : AdLoad.sliderSmallNativeAd(logic.accountingAd),
                            )
                                : Container(),
                            _widgetLearnBanking(logic),
                            _widgetFinanceLearn(logic),
                            _widgetSavingAccount(logic, context),
                            _widgetPersonalLoan(logic, context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }

  Widget _appBar(AccountingController logic, BuildContext context) {
    return Container(
      color: CColor.white,
      padding: EdgeInsets.only(
        left: Sizes.width_5,
        right: Sizes.width_5,
        top: Sizes.height_1_5,
        bottom: Sizes.height_1_5,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              size: Sizes.height_3_5,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: Sizes.width_4,
              ),
              child: Center(
                child: Text(
                  logic.categoryFinanceClass!.title.toString(),
                  style: TextStyle(
                    fontFamily: Font.quattrocento,
                    color: CColor.black,
                    fontSize: FontSize.size_13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          Icon(
            Icons.keyboard_arrow_left_rounded,
            size: Sizes.height_3_5,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }

  _firstViewHeader() {
    return Container(
      color: CColor.backgroundColor,
      padding: EdgeInsets.only(
          left: Sizes.width_3,
          top: Sizes.height_5,
          bottom: Sizes.height_5,
          right: Sizes.width_1),
      child: Row(
        children: [
          Image.asset(
            "assets/images/ic_accounting.png",
            height: Sizes.height_9,
            width: Sizes.height_9,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: Sizes.width_3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "txtLearnBankingFinance".tr,
                    style: TextStyle(
                      color: CColor.black,
                      fontFamily: Font.quattrocento,
                      fontSize: FontSize.size_12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Sizes.height_1, right: Sizes.width_2),
                    child: Text(
                      "txtLearnBankingFinanceDesc".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: CColor.black,
                        fontFamily: Font.quattrocento,
                        fontSize: FontSize.size_10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ****************************Blog and news section*****************************
  _widgetBlogNews(AccountingController logic, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: Sizes.width_5,
                  top: Sizes.height_2,
                ),
                child: Text(
                  "txtBlogNews".tr,
                  style: TextStyle(
                    color: CColor.black,
                    fontFamily: Font.quattrocento,
                    fontSize: FontSize.size_12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (Debug.adType == Debug.adGoogleType) {
                  InterstitialAdClass.showInterstitialAdInterCount(context, () {
                    Get.toNamed(AppRoutes.viewAll,
                        arguments: ["txtLearnBlogNews".tr, logic.blogData]);
                  });
                } else {
                  InterstitialFacebookAdClass
                      .showInterstitialFacebookAdInterCount(context, () {
                    Get.toNamed(AppRoutes.viewAll,
                        arguments: ["txtLearnBlogNews".tr, logic.blogData]);
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: Sizes.width_5,
                  top: Sizes.height_2,
                ),
                child: Text(
                  "txtViewAll".tr,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: CColor.black,
                    fontFamily: Font.quattrocento,
                    fontSize: FontSize.size_10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            if (Debug.adType == Debug.adGoogleType) {
              InterstitialAdClass.showInterstitialAdInterCount(context, () {
                Get.toNamed(AppRoutes.listOfTask,
                    arguments: [logic.blogData, logic.blogTitle, 0]);
              });
            } else {
              InterstitialFacebookAdClass.showInterstitialFacebookAdInterCount(
                  context, () {
                Get.toNamed(AppRoutes.listOfTask,
                    arguments: [logic.blogData, logic.blogTitle, 0]);
              });
            }
          },
          child: Container(
            width: double.infinity,
            height: Sizes.height_20,
            margin: EdgeInsets.symmetric(
                horizontal: Sizes.width_3, vertical: Sizes.height_2),
            padding: EdgeInsets.all(Sizes.width_5),
            decoration: BoxDecoration(
                color: CColor.backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  child: /*Image.asset(
                    "assets/images/ic_bank.png",
                    height: Sizes.height_8,
                    width: Sizes.height_8,
                  ),*/
                      Image.network(
                    logic.blogUrl,
                    height: Sizes.height_9,
                    width: Sizes.height_9,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Sizes.height_2),
                  child: Text(
                    logic.blogTitle,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CColor.black,
                      fontFamily: Font.quattrocento,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize.size_10,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// **************************** Introduction *****************************
  _widgetLearnBanking(AccountingController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: Sizes.width_5,
            top: Sizes.height_2,
          ),
          child: Text(
            "txtLearnIntroduction".tr,
            style: TextStyle(
              color: CColor.black,
              fontFamily: Font.quattrocento,
              fontSize: FontSize.size_12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Sizes.width_3, vertical: Sizes.height_2),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: logic.introductionData[0].detail!.length,
            itemBuilder: (context, index) {
              return _listItemLearnBanking(index, logic, context);
            },
          ),
        )
      ],
    );
  }

  _listItemLearnBanking(
      int index, AccountingController logic, BuildContext context) {
    return InkWell(
      onTap: () {
        if (Debug.adType == Debug.adGoogleType) {
          InterstitialAdClass.showInterstitialAdInterCount(
            context,
            () {
              Get.toNamed(AppRoutes.listOfTask, arguments: [
                logic.introductionData,
                logic.introductionData[0].detail![index].title.toString(),
                index
              ]);
            },
          );
        } else {
          InterstitialFacebookAdClass.showInterstitialFacebookAdInterCount(
              context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.introductionData,
              logic.introductionData[0].detail![index].title.toString(),
              index
            ]);
          });
        }
      },
      child: Container(
        width: Sizes.width_40,
        height: 150,
        // margin: EdgeInsets.symmetric(horizontal: Sizes.width_1),
        padding: EdgeInsets.all(Sizes.width_5),
        decoration: BoxDecoration(
            color: CColor.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: /*Image.asset(
                "assets/images/ic_bank.png",
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),*/
                  Image.network(
                logic.introductionData[0].detail![index].image.toString(),
                height: Sizes.height_9,
                width: Sizes.height_9,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Sizes.height_2),
              child: Text(
                overflow: TextOverflow.ellipsis,
                logic.introductionData[0].detail![index].title.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CColor.black,
                  fontFamily: Font.quattrocento,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.size_10,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **************************** Accounting Basics *****************************
  _widgetFinanceLearn(AccountingController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: Sizes.width_5,
            top: Sizes.height_2,
          ),
          child: Text(
            "txtLearnAccountingBasics".tr,
            style: TextStyle(
              fontFamily: Font.quattrocento,
              color: CColor.black,
              fontSize: FontSize.size_12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Sizes.width_3, vertical: Sizes.height_2),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: logic.accountingData[0].detail!.length,
            itemBuilder: (context, index) {
              return _listItemLearnFinance(index, logic, context);
            },
          ),
        )
      ],
    );
  }

  _listItemLearnFinance(
      int index, AccountingController logic, BuildContext context) {
    return InkWell(
      onTap: () {
        if (Debug.adType == Debug.adGoogleType) {
          InterstitialAdClass.showInterstitialAdInterCount(context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.accountingData,
              logic.accountingData[0].detail![index].title.toString(),
              index
            ]);
          });
        } else {
          InterstitialFacebookAdClass.showInterstitialFacebookAdInterCount(
              context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.accountingData,
              logic.accountingData[0].detail![index].title.toString(),
              index
            ]);
          });
        }
      },
      child: Container(
        width: Sizes.width_40,
        height: 150,
        // margin: EdgeInsets.symmetric(horizontal: Sizes.width_1),
        padding: EdgeInsets.all(Sizes.width_5),
        decoration: BoxDecoration(
            color: CColor.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: /*Image.asset(
                "assets/images/ic_bank.png",
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),*/
                  Image.network(
                logic.accountingData[0].detail![index].image.toString(),
                height: Sizes.height_9,
                width: Sizes.height_9,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Sizes.height_2),
              child: Text(
                overflow: TextOverflow.ellipsis,
                logic.accountingData[0].detail![index].title.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CColor.black,
                  fontFamily: Font.quattrocento,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.size_10,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **************************** Evolution of Accounting *****************************
  _widgetSavingAccount(AccountingController logic, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: Sizes.width_5,
                  top: Sizes.height_2,
                ),
                child: Text(
                  "txtLearnEvolution".tr,
                  style: TextStyle(
                    color: CColor.black,
                    fontFamily: Font.quattrocento,
                    fontSize: FontSize.size_12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (Debug.adType == Debug.adGoogleType) {
                  InterstitialAdClass.showInterstitialAdInterCount(context, () {
                    Get.toNamed(AppRoutes.viewAll, arguments: [
                      "txtLearnEvolution".tr,
                      logic.evolutionData
                    ]);
                  });
                } else {
                  InterstitialFacebookAdClass
                      .showInterstitialFacebookAdInterCount(context, () {
                    Get.toNamed(AppRoutes.viewAll, arguments: [
                      "txtLearnEvolution".tr,
                      logic.evolutionData
                    ]);
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: Sizes.width_5,
                  top: Sizes.height_2,
                ),
                child: Text(
                  "txtViewAll".tr,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: CColor.black,
                    fontFamily: Font.quattrocento,
                    fontSize: FontSize.size_10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Sizes.width_3, vertical: Sizes.height_2),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _listItemSavingAccount(index, logic, context);
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            scrollDirection: Axis.vertical,
          ),
        )
      ],
    );
  }

  _listItemSavingAccount(
      int index, AccountingController logic, BuildContext context) {
    return InkWell(
      onTap: () {
        if (Debug.adType == Debug.adGoogleType) {
          InterstitialAdClass.showInterstitialAdInterCount(context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.evolutionData,
              logic.evolutionData[0].detail![index].title.toString(),
              index
            ]);
          });
        } else {
          InterstitialFacebookAdClass.showInterstitialFacebookAdInterCount(
              context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.evolutionData,
              logic.evolutionData[0].detail![index].title.toString(),
              index
            ]);
          });
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Sizes.height_0_7),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: CColor.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: /*Image.asset(
                "assets/images/ic_bank.png",
                height: Sizes.height_5,
                width: Sizes.height_5,
              ),*/
                  Image.network(
                logic.evolutionData[0].detail![index].image.toString(),
                height: Sizes.height_5,
                width: Sizes.height_5,
              ),
            ),
            Text(
              logic.evolutionData[0].detail![index].title.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: CColor.black,
                fontFamily: Font.quattrocento,
                fontSize: FontSize.size_12,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// **************************** Advanced Topics *****************************
  _widgetPersonalLoan(AccountingController logic, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: Sizes.width_5,
                  top: Sizes.height_2,
                ),
                child: Text(
                  "txtLearnTopics".tr,
                  style: TextStyle(
                    fontFamily: Font.quattrocento,
                    color: CColor.black,
                    fontSize: FontSize.size_12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (Debug.adType == Debug.adGoogleType) {
                  InterstitialAdClass.showInterstitialAdInterCount(context, () {
                    Get.toNamed(AppRoutes.viewAll, arguments: [
                      "txtLearnTopics".tr,
                      logic.advancedTopicData
                    ]);
                  });
                } else {
                  InterstitialFacebookAdClass
                      .showInterstitialFacebookAdInterCount(context, () {
                    Get.toNamed(AppRoutes.viewAll, arguments: [
                      "txtLearnTopics".tr,
                      logic.advancedTopicData
                    ]);
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: Sizes.width_5,
                  top: Sizes.height_2,
                ),
                child: Text(
                  "txtViewAll".tr,
                  style: TextStyle(
                    fontFamily: Font.quattrocento,
                    decoration: TextDecoration.underline,
                    color: CColor.black,
                    fontSize: FontSize.size_10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Sizes.width_3, vertical: Sizes.height_2),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              return _listItemPersonalLoan(index, logic, context);
            },
          ),
        )
      ],
    );
  }

  _listItemPersonalLoan(
      int index, AccountingController logic, BuildContext context) {
    return InkWell(
      onTap: () {
        if (Debug.adType == Debug.adGoogleType) {
          InterstitialAdClass.showInterstitialAdInterCount(context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.advancedTopicData,
              logic.advancedTopicData[0].detail![index].title.toString(),
              index
            ]);
          });
        } else {
          InterstitialFacebookAdClass.showInterstitialFacebookAdInterCount(
              context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.advancedTopicData,
              logic.advancedTopicData[0].detail![index].title.toString(),
              index
            ]);
          });
        }
      },
      child: Container(
        width: Sizes.width_40,
        height: 150,
        // margin: EdgeInsets.symmetric(horizontal: Sizes.width_1),
        padding: EdgeInsets.all(Sizes.width_5),
        decoration: BoxDecoration(
            color: CColor.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: /*Image.asset(
                "assets/images/ic_bank.png",
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),*/
                  Image.network(
                logic.advancedTopicData[0].detail![index].image.toString(),
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Sizes.height_2),
              child: Text(
                overflow: TextOverflow.ellipsis,
                logic.advancedTopicData[0].detail![index].title.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CColor.black,
                  fontFamily: Font.quattrocento,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.size_10,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
