import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/sizer_utils.dart';

import '../../../facebook_ads/inter/inter_ad.dart';
import '../../../google_ads/inter/inter_ad.dart';
import '../../../offline/offline_screen.dart';
import '../../../utils/debug.dart';
import '../../../utils/font.dart';
import '../../../utils/utils.dart';
import '../controllers/view_all_controller.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewAllController>(builder: (logic) {
      return Scaffold(
        backgroundColor: CColor.white,
        body: SafeArea(
          child: GetBuilder<ViewAllController>(
            builder: (logic) {
              return logic.string == "Offline"
                  ? OfflineScreen()
                  : Column(
                      children: [
                        _appBar(logic, context),
                        _widgetViewAll(logic),
                        // Container(
                        //   margin: const EdgeInsets.only(bottom: 1),
                        //   decoration: BoxDecoration(
                        //     color: CColor.opacityBlack10,
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   height: 200,
                        //   width: double.infinity,
                        //   alignment: Alignment.center,
                        //   child:
                        (Debug.isShowAd && Debug.isNativeAd)? Utils.smallNativeAd(logic.viewAllAd, context)!:Container()
                        // ),
                      ],
                    );
            },
          ),
        ),
      );
    });
  }

  Widget _appBar(ViewAllController logic, BuildContext context) {
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
              child: Text(
                logic.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Font.quattrocento,
                  color: CColor.black,
                  fontSize: FontSize.size_12,
                  fontWeight: FontWeight.w800,
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

  _widgetViewAll(ViewAllController logic) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Sizes.width_3, vertical: Sizes.height_2),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _listItemViewAll(index, logic, context);
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: logic.bankData[0].detail!.length,
            scrollDirection: Axis.vertical,
            /* separatorBuilder: (BuildContext context, int index) {
              return _separatorListItemViewAll(context, index);
            },*/
          ),
        ),
      ),
    );
  }

  _listItemViewAll(int index, ViewAllController logic, BuildContext context) {
    return InkWell(
      onTap: () {
        if (Debug.adType == Debug.adGoogleType) {
          InterstitialAdClass.showInterstitialAdInterCount(context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.bankData,
              logic.bankData[0].detail![index].title.toString(),
              index
            ]);
          });
        } else {
          InterstitialFacebookAdClass.showInterstitialFacebookAdInterCount(
              context, () {
            Get.toNamed(AppRoutes.listOfTask, arguments: [
              logic.bankData,
              logic.bankData[0].detail![index].title.toString(),
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
              child:
              Image.network(
                logic.bankData[0].detail![0].image.toString(),
                height: Sizes.height_7,
                width: Sizes.height_6,
              ),
              // Image.asset(
              //   "assets/images/ic_bank.png",
              //   height: Sizes.height_5,
              //   width: Sizes.height_5,
              // ),
            ),
            Text(
              logic.bankData[0].detail![index].title.toString(),
              style: TextStyle(
                fontFamily: Font.quattrocento,
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
