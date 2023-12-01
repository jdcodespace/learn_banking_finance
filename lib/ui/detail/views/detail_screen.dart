import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/sizer_utils.dart';
import '../../../ad_mediation/ad_load.dart';
import '../../../facebook_ads/native/facebook_native_banner.dart';
import '../../../facebook_ads/native/facebook_native_small.dart';
import '../../../google_ads/native/native_banner_page_without_preload.dart';
import '../../../offline/offline_screen.dart';
import '../../../utils/constant.dart';
import '../../../utils/debug.dart';
import '../../../utils/font.dart';
import '../controllers/detail_controller.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(builder: (logic) {
      return Scaffold(
        backgroundColor: CColor.white,
        body: SafeArea(
          child: GetBuilder<DetailController>(
            builder: (logic) {
              return logic.string == "Offline"
                  ? OfflineScreen()
                  : Column(
                      children: [
                        _appBar(logic, context),
                        _centerView(logic),
                        (Debug.isShowAd && Debug.isNativeAd)
                            ? Visibility(
                                visible: logic.isLoaded,
                                child: Container(
                                  child: (Debug.adType == Debug.adGoogleType &&
                                          Debug.isShowAd &&
                                          Debug.isNativeAd)
                                      ? NativeInlinePageBannerWithoutPreload(
                                          context: context,
                                          function: (isLoaded) {
                                            logic.onChangeNativeBannerAd(
                                                isLoaded);
                                          },
                                        )
                                      : const FacebookBannerNative(),
                                ),
                              )
                            : Container()
                      ],
                    );
            },
          ),
        ),
      );
    });
  }

  Widget _appBar(DetailController logic, BuildContext context) {
    return GetBuilder<DetailController>(
        id: Constant.idAppBar,
        builder: (logic) {
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
                const Spacer(),
                _nextPreviousButton(logic),
                InkWell(
                  onTap: () {
                    logic.bookMarkTap(context);
                  },
                  child: Icon(
                    (!logic.isTips)
                        ? (logic.bankData.isNotEmpty &&
                                logic.bankData[0].detail![logic.mainIndex]
                                    .dataList![logic.subIndex].isMark
                            ? Icons.bookmark
                            : Icons.bookmark_border_rounded)
                        : (logic.isTips)
                            ? (logic.tipsData.isNotEmpty &&
                                    logic.tipsData[logic.mainIndex].isMark)
                                // logic.tipsData[logic.pageController.page!.toInt()].isMark)
                                ? Icons.bookmark
                                : Icons.bookmark_border_rounded
                            : Icons.bookmark_border_rounded,
                    size: Sizes.height_3,
                  ),
                ),
              ],
            ),
          );
        });
  }

  _centerView(DetailController logic) {
    return Expanded(
      child: PageView.builder(
        controller: logic.pageController,
        itemBuilder: (context, index) {
          return _descriptionItem(logic, index, context);
        },
        itemCount: (logic.isTips)
            ? logic.tipsData.length
            : (logic.bankData.isNotEmpty)
                ? logic.bankData[0].detail![logic.mainIndex].dataList!.length
                : 0,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          logic.changedValuesForPage(value);
        },
      ),
    );
  }

  _descriptionItem(DetailController logic, int index, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            height: Get.height * 0.21,
            color: CColor.backgroundColor,
            child: Text(
              (logic.isTips)
                  ? logic.tipsData[index].title.toString()
                  : logic.bankData[0].detail![logic.mainIndex].dataList![index]
                      .title
                      .toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Font.quattrocento,
                fontSize: FontSize.size_20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          (Debug.isShowAd && Debug.isNativeAd)
              ? Container(
                  decoration: BoxDecoration(
                    // color: CColor.backgroundColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: (Debug.adType == Debug.adGoogleType &&
                          Debug.isShowAd &&
                          Debug.isNativeAd)
                      ? (logic.isTips)
                          ? ((logic.tipsData[index].adNativeSmall != null)
                              ? SizedBox(
                                  height: Get.height * 0.21,
                                  child: AdWidget(
                                      ad: logic.tipsData[index].adNativeSmall!),
                                )
                              : Container())
                          : ((logic.bankData[0].detail![logic.mainIndex]
                                      .dataList![index].adNativeSmall !=
                                  null)
                              ? SizedBox(
                                  height: Get.height * 0.21,
                                  child: AdWidget(
                                      ad: logic
                                          .bankData[0]
                                          .detail![logic.mainIndex]
                                          .dataList![index]
                                          .adNativeSmall!),
                                )
                              : Container())
                      : smallNativeAdFacebook(context),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              (logic.isTips)
                  ? logic.tipsData[index].desc.toString()
                  : logic.bankData[0].detail![logic.mainIndex].dataList![index]
                      .desc
                      .toString(),
              style: TextStyle(
                  fontFamily: Font.quattrocento,
                  fontSize: FontSize.size_12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5),
            ),
          )
        ],
      ),
    );
  }

  _nextPreviousButton(DetailController logic) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.width_7),
      child: Row(
        children: [
          (logic.intPosition == 0 && logic.subIndex == 0)
              ? Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.transparent,
                  ),
                )
              : InkWell(
                  onTap: () {
                    logic.nextPrevPage(false);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    // color: CColor.red,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
          const SizedBox(width: 25),
          (logic.isTips)
              ? (logic.intPosition != logic.tipsData.length - 1 &&
                      logic.subIndex != logic.tipsData.length - 1)
                  ? InkWell(
                      onTap: () {
                        logic.nextPrevPage(true);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.transparent,
                      ),
                    )
              : (logic.intPosition !=
                          logic.bankData[0].detail![logic.mainIndex].dataList!
                                  .length -
                              1 &&
                      logic.subIndex !=
                          logic.bankData[0].detail![logic.mainIndex].dataList!
                                  .length -
                              1)
                  ? InkWell(
                      onTap: () {
                        logic.nextPrevPage(true);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.transparent,
                      ),
                    ),
        ],
      ),
    );
  }
}
