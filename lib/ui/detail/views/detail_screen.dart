import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/sizer_utils.dart';
import '../../../facebook_ads/inter/interAd.dart';
import '../../../facebook_ads/native/facebook_native_banner.dart';
import '../../../facebook_ads/native/facebook_native_small.dart';
import '../../../google_ads/native/native_banner_page.dart';
import '../../../google_ads/native/native_banner_page_without_preload.dart';
import '../../../google_ads/native/native_small_page.dart';
import '../../../offline/offline_screen.dart';
import '../../../utils/debug.dart';
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
                        Visibility(
                          visible:logic.isLoaded ,
                          child: Container(
                            child: (Debug.adType == Debug.adGoogleType &&
                                    Debug.isShowAd &&
                                    Debug.isNativeAd)
                                ? NativeInlinePageBannerWithoutPreload(context: context,function:(isLoaded){
                                  logic.onChangeNativeBannerAd(isLoaded);
                            },)
                                : const FacebookBannerNative(),
                          ),
                        )
                        // _nextPreviousButton(logic),
                      ],
                    );
            },
          ),
        ),
      );
    });
  }

  Widget _appBar(DetailController logic, BuildContext context) {
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
              Icons.arrow_back_ios_new_rounded,
              size: Sizes.height_2,
            ),
          ),
          const Spacer(),
          _nextPreviousButton(logic),
          // Expanded(
          //   child: Text(
          //     "Detail",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: CColor.black,
          //       fontWeight: FontWeight.w700,
          //       fontSize: FontSize.size_14,
          //     ),
          //   ),
          // ),

          InkWell(
            onTap: () {
              InterstitialAdClass.showInterstitialAdInterCount(context, () {
                Get.back();
              });
            },
            child: Icon(
              Icons.bookmark_border_rounded,
              size: Sizes.height_3,
            ),
          ),
        ],
      ),
    );
  }

  _centerView(DetailController logic) {
    return Expanded(
      child: PageView.builder(
        controller: logic.pageController,
        itemBuilder: (context, index) {
          return _descriptionItem(logic, index, context);
        },
        itemCount: (logic.isTips == true)
            ? logic.tipsData.length
            : logic.bankData[0].detail![logic.mainIndex].dataList!.length,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  _descriptionItem(DetailController logic, int index, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: Get.height * 0.21,
            color: CColor.backgroundColor,
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  (logic.isTips == true)
                      ? logic.tipsData[index].title.toString()
                      : logic.bankData[0].detail![logic.mainIndex]
                          .dataList![index].title
                          .toString(),
                  style: TextStyle(
                    fontSize: FontSize.size_20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: Get.height * 0.25,
            decoration: BoxDecoration(
              // color: CColor.backgroundColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: (Debug.adType == Debug.adGoogleType &&
                    Debug.isShowAd &&
                    Debug.isNativeAd)
                // ? NativeInlinePageSmall(context: context)
                ? logic.bankData[0].detail![logic.mainIndex]
                .dataList![index].nativeInlinePage
                : smallNativeAdFacebook(context),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              (logic.isTips == true)
                  ? logic.tipsData[index].desc.toString()
                  : logic.bankData[0].detail![logic.mainIndex].dataList![index]
                      .desc
                      .toString(),
              style: TextStyle(
                fontSize: FontSize.size_12,
                fontWeight: FontWeight.w400,
              ),
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
          InkWell(
            onTap: () {
              logic.pageController.previousPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn);
            },
            // child: const CircleAvatar(
            //   maxRadius: 25,
            //   backgroundColor: CColor.backgroundColor,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            // ),
          ),
          const SizedBox(width: 25),
          // const Spacer(),
          InkWell(
            onTap: () {
              logic.pageController.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn);
            },
            // child: const CircleAvatar(
            //   maxRadius: 25,
            //   backgroundColor: CColor.backgroundColor,
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
            // ),
          ),
        ],
      ),
    );
  }
}
