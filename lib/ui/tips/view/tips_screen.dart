import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import '../../../utils/utils.dart';
import '../controller/tips_controller.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TipsController>(builder: (logic) {
      return Scaffold(
        backgroundColor: CColor.white,
        body: SafeArea(
          child: GetBuilder<TipsController>(
            builder: (logic) {
              return logic.string == "Offline"
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
                                _widgetTipsAll(logic),
                              ],
                            ),
                          ),
                        ),
                        (Debug.isShowAd && Debug.isNativeAd)
                            ? Container(
                          child: (Debug.adType == Debug.adFacebookType)
                              ? (Constant.adGoogle)
                              ? AdLoad.sliderSmallNativeAd(logic.tipsAd)
                              : AdLoad.smallFacebookAd(() {})
                              : (Constant.isFacebookAd)
                              ? AdLoad.smallFacebookAd(() {})
                              : AdLoad.sliderSmallNativeAd(logic.tipsAd),
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

  Widget _appBar(TipsController logic, BuildContext context) {
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
            child: Text(
              "Tips",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Font.quattrocento,
                color: CColor.black,
                fontWeight: FontWeight.w700,
                fontSize: FontSize.size_14,
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
            "assets/images/ic_tip.png",
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
                    "txtTips".tr,
                    style: TextStyle(
                      fontFamily: Font.quattrocento,
                      color: CColor.black,
                      fontSize: FontSize.size_12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: Sizes.height_1, right: Sizes.width_2),
                    child: Text(
                      "txtTipsDesc".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: Font.quattrocento,
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

  _widgetTipsAll(TipsController logic) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Sizes.width_3, vertical: Sizes.height_2),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _listItemViewAll(index, logic, context);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: logic.tipsData.length,
        scrollDirection: Axis.vertical,
        // separatorBuilder: (BuildContext context, int index) {
        //   return _separatorListItemViewAll(context, index);
        // },
      ),
    );
  }

  _listItemViewAll(int index, TipsController logic, BuildContext context) {
    return InkWell(
      onTap: () {
        if (Debug.adType == Debug.adGoogleType) {
          InterstitialAdClass.showInterstitialAdInterCount(context, () {
            Get.toNamed(AppRoutes.detail,
                arguments: [true, logic.tipsData, index, null]);
          });
        } else {
          InterstitialFacebookAdClass.showInterstitialFacebookAdInterCount(
              context, () {
            Get.toNamed(AppRoutes.detail,
                arguments: [true, logic.tipsData, index, null]);
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
                  logic.tipsData[index].image.toString(),
                  height: Sizes.height_5,
                  width: Sizes.height_5,
                )),
            Expanded(
              child: Text(
                logic.tipsData[index].title.toString(),
                style: TextStyle(
                  fontFamily: Font.quattrocento,
                  color: CColor.black,
                  fontSize: FontSize.size_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_outlined, size: 17)
          ],
        ),
      ),
    );
  }

// _separatorListItemViewAll(BuildContext context, int index) {
//   if ((index + 1) % 3 == 0) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: Sizes.height_0_7),
//       height: Get.height * 0.1,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//           color: CColor.backgroundColor,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.black)),
//       child: /*(Debug.adType == Debug.adGoogleType &&
//               Debug.isShowAd &&
//               Debug.isShowBanner)
//           ? NativeInlinePageBanner(context: context)
//           : const FacebookBannerNative(),*/
//           const Text(
//         "Banner Native",
//         textAlign: TextAlign.center,
//       ),
//     );
//   } else {
//     return Container();
//   }
// }
}
