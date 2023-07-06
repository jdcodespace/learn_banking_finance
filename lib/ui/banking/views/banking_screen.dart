import 'package:flutter/material.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/ui/banking/controllers/banking_controller.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/sizer_utils.dart';
import '../../../facebook_ads/inter/inter_ad.dart';
import '../../../google_ads/inter/inter_ad.dart';
import '../../../offline/offline_screen.dart';
import '../../../utils/debug.dart';
import '../../../utils/font.dart';
import '../../../utils/utils.dart';

class BankingScreen extends StatelessWidget {
  const BankingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BankingController>(builder: (logic) {
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
                            // Container(
                            //   margin: const EdgeInsets.only(bottom: 1),
                            //   decoration: BoxDecoration(
                            //     color: CColor.opacityBlack10,
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            //   // height: 200,
                            //   width: double.infinity,
                            //   alignment: Alignment.center,
                            //   child: /*(Debug.adType == Debug.adGoogleType &&
                            //           Debug.isShowAd &&
                            //           Debug.isNativeAd)
                            //       // ? Utils.getAdNativeSmallAd()
                            //       ? NativeInlinePageSmall(context: context)
                            //       : smallNativeAdFacebook(context),*/
                              Utils.smallNativeAd(logic.bankingAd, context)!,
                            // ),
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

  Widget _appBar(BankingController logic, BuildContext context) {
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
                    fontFamily: Font.poppins,
                    color: CColor.black,
                    fontSize: FontSize.size_12,
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
            "assets/images/ic_bank.png",
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
                    "txtBankingFinance".tr,
                    style: TextStyle(
                      fontFamily: Font.poppins,
                      color: CColor.black,
                      fontSize: FontSize.size_12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Sizes.height_1, right: Sizes.width_2),
                    child: Text(
                      "txtBankingFinanceDesc".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: Font.poppins,
                        color: CColor.black,
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

  /// **************************** Blog and news section *****************************
  _widgetBlogNews(BankingController logic, BuildContext context) {
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
                    fontFamily: Font.poppins,
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
                    Get.toNamed(AppRoutes.viewAll,
                        arguments: ["txtBlogNews".tr, logic.blogData]);
                  });
                } else {
                  InterstitialFacebookAdClass
                      .showInterstitialFacebookAdInterCount(context, () {
                    Get.toNamed(AppRoutes.viewAll,
                        arguments: ["txtBlogNews".tr, logic.blogData]);
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
                    fontFamily: Font.poppins,
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
                    height: Sizes.height_5,
                    width: Sizes.height_5,
                  ),*/
                  Image.network(
                    logic.blogUrl,
                    height: Sizes.height_5,
                    width: Sizes.height_5,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Sizes.height_2),
                  child: Text(
                    logic.blogTitle,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Font.poppins,
                      color: CColor.black,
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

  /// **************************** Learn banking section *****************************
  _widgetLearnBanking(BankingController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: Sizes.width_5,
            top: Sizes.height_2,
          ),
          child: Text(
            "txtLearnBanking".tr,
            style: TextStyle(
              fontFamily: Font.poppins,
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
            itemCount: logic.learnBankingData[0].detail!.length,
            itemBuilder: (context, index) {
              return _listItemLearnBanking(index, logic, context);
            },
          ),
        )
      ],
    );
  }

  _listItemLearnBanking(
      int index, BankingController logic, BuildContext context) {
    return InkWell(
      onTap: () {
        if (Debug.adType == Debug.adGoogleType) {
          InterstitialAdClass.showInterstitialAdInterCount(context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.learnBankingData,
              logic.learnBankingData[0].detail![index].title.toString(),
              index
            ]);
          });
        } else {
          InterstitialFacebookAdClass.showInterstitialFacebookAdInterCount(
              context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.learnBankingData,
              logic.learnBankingData[0].detail![index].title.toString(),
              index
            ]);
          });
        }
      },
      child: Container(
        width: Sizes.width_40,
        height: 150,
        padding: EdgeInsets.all(Sizes.width_5),
        decoration: BoxDecoration(
            color: CColor.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                "assets/images/ic_bank.png",
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),
             /* Image.network(
                logic.learnBankingData[0].detail![index].image.toString(),
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),*/
            ),
            Container(
              padding: EdgeInsets.only(top: Sizes.height_2),
              child: Text(
                overflow: TextOverflow.ellipsis,
                logic.learnBankingData[0].detail![index].title.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  color: CColor.black,
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

  /// **************************** Finance guide *****************************
  _widgetFinanceLearn(BankingController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: Sizes.width_5,
            top: Sizes.height_2,
          ),
          child: Text(
            "txtFinanceGuide".tr,
            style: TextStyle(
              fontFamily: Font.poppins,
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
            itemCount: logic.financeData[0].detail!.length,
            itemBuilder: (context, index) {
              return _listItemLearnFinance(index, logic, context);
            },
          ),
        )
      ],
    );
  }

  _listItemLearnFinance(
      int index, BankingController logic, BuildContext context) {
    return InkWell(
      onTap: () {
        if (Debug.adType == Debug.adGoogleType) {
          InterstitialAdClass.showInterstitialAdInterCount(context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.financeData,
              logic.financeData[0].detail![index].title.toString(),
              index
            ]);
          });
        } else {
          InterstitialFacebookAdClass.showInterstitialFacebookAdInterCount(
              context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.financeData,
              logic.financeData[0].detail![index].title.toString(),
              index
            ]);
          });
        }
      },
      child: Container(
        width: Sizes.width_40,
        height: 150,
        padding: EdgeInsets.all(Sizes.width_5),
        decoration: BoxDecoration(
            color: CColor.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                "assets/images/ic_bank.png",
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),
              /* Image.network(
                logic.financeData[0].detail![index].image.toString(),
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),*/
            ),
            Container(
              padding: EdgeInsets.only(top: Sizes.height_2),
              child: Text(
                overflow: TextOverflow.ellipsis,
                logic.financeData[0].detail![index].title.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  color: CColor.black,
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

  /// **************************** Saving account *****************************
  _widgetSavingAccount(BankingController logic, BuildContext context) {
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
                  "txtSavingAccount".tr,
                  style: TextStyle(
                    fontFamily: Font.poppins,
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
                      "txtSavingAccount".tr,
                      logic.savingAccountData
                    ]);
                  });
                } else {
                  InterstitialFacebookAdClass
                      .showInterstitialFacebookAdInterCount(context, () {
                    Get.toNamed(AppRoutes.viewAll, arguments: [
                      "txtSavingAccount".tr,
                      logic.savingAccountData
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
                    fontFamily: Font.poppins,
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
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _listItemSavingAccount(index, logic, context);
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            scrollDirection: Axis.vertical,
          ),
        )
      ],
    );
  }

  _listItemSavingAccount(
      int index, BankingController logic, BuildContext context) {
    return InkWell(
      onTap: () {
        if (Debug.adType == Debug.adGoogleType) {
          InterstitialAdClass.showInterstitialAdInterCount(context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.savingAccountData,
              logic.savingAccountData[0].detail![index].title.toString(),
              index
            ]);
          });
        } else {
          InterstitialFacebookAdClass.showInterstitialFacebookAdInterCount(
              context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.savingAccountData,
              logic.savingAccountData[0].detail![index].title.toString(),
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
              child: Image.asset(
                "assets/images/ic_bank.png",
                height: Sizes.height_5,
                width: Sizes.height_5,
              ),
              /* Image.network(
                logic.savingAccountData[0].detail![index].image.toString(),
                height: Sizes.height_5,
                width: Sizes.height_5,
              ),*/
            ),
            Text(
              logic.savingAccountData[0].detail![index].title.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Font.poppins,
                color: CColor.black,
                fontSize: FontSize.size_12,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// **************************** Personal load guide *****************************
  _widgetPersonalLoan(BankingController logic, BuildContext context) {
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
                  "txtPersonalLoan".tr,
                  style: TextStyle(
                    fontFamily: Font.poppins,
                    color: CColor.black,
                    fontSize: FontSize.size_12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                InterstitialAdClass.showInterstitialAdInterCount(context, () {
                  Get.toNamed(AppRoutes.viewAll,
                      arguments: ["txtPersonalLoan".tr, logic.loanGuideData]);
                });
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: Sizes.width_5,
                  top: Sizes.height_2,
                ),
                child: Text(
                  "txtViewAll".tr,
                  style: TextStyle(
                    fontFamily: Font.poppins,
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
      int index, BankingController logic, BuildContext context) {
    return InkWell(
      onTap: () {
        if (Debug.adType == Debug.adGoogleType) {
          InterstitialAdClass.showInterstitialAdInterCount(context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.loanGuideData,
              logic.loanGuideData[0].detail![index].title.toString(),
              index
            ]);
          });
        } else {
          InterstitialFacebookAdClass.showInterstitialFacebookAdInterCount(
              context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.loanGuideData,
              logic.loanGuideData[0].detail![index].title.toString(),
              index
            ]);
          });
        }
      },
      child: Container(
        width: Sizes.width_40,
        height: 150,
        padding: EdgeInsets.all(Sizes.width_5),
        decoration: BoxDecoration(
            color: CColor.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                "assets/images/ic_bank.png",
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),
              /* Image.network(
                logic.loanGuideData[0].detail![index].image.toString(),
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),*/
            ),
            Container(
              padding: EdgeInsets.only(top: Sizes.height_2),
              child: Text(
                overflow: TextOverflow.ellipsis,
                logic.loanGuideData[0].detail![index].title.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  color: CColor.black,
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
