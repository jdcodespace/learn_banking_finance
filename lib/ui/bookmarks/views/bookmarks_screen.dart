import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/ui/bookmarks/controller/bookmarks_controller.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/sizer_utils.dart';
import '../../../datamodel/bank_data.dart';
import '../../../facebook_ads/native/facebook_native_small.dart';
import '../../../google_ads/native/native_small_page.dart';
import '../../../offline/offline_screen.dart';
import '../../../utils/debug.dart';
import '../../../utils/font.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookMarkController>(builder: (logic) {
      return Scaffold(
        backgroundColor: CColor.white,
        body: SafeArea(
          child: GetBuilder<BookMarkController>(
            builder: (logic) {
              return logic.string == "Offline"
                  ? OfflineScreen()
                  : Column(
                      children: [
                        _appBar(logic, context),
                        (logic.listData.isNotEmpty)
                            ? _widgetViewAll(logic)
                            : Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: Get.height * 0.07),
                                      Image.asset(
                                          "assets/images/course_not_found_icon.png"),
                                      Expanded(
                                        child: Text(
                                          "txtNoDataFound".tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: Font.poppins,
                                            color: CColor.black,
                                            fontSize: FontSize.size_12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          margin:
                                               EdgeInsets.only(bottom:Get.height*0.005),
                                          decoration: BoxDecoration(
                                            color: CColor.opacityBlack10,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          height: 200,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: (Debug.adType ==
                                                      Debug.adGoogleType &&
                                                  Debug.isShowAd &&
                                                  Debug.isNativeAd)
                                              ? NativeInlinePageSmall(
                                                  context: context)
                                              : smallNativeAdFacebook(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                      ],
                    );
            },
          ),
        ),
      );
    });
  }

  Widget _appBar(BookMarkController logic, BuildContext context) {
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
              "Bookmarks",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Font.poppins,
                color: CColor.black,
                fontWeight: FontWeight.w600,
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

  _widgetViewAll(BookMarkController logic) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Sizes.width_3, vertical: Sizes.height_2),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return _listItemViewAll(
                index, logic.listData[index], logic.listData, logic);
          },
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: logic.listData.length,
          scrollDirection: Axis.vertical,
          separatorBuilder: (BuildContext context, int index) {
            return _separatorListItemViewAll(context, index);
          },
        ),
      ),
    );
  }

  _listItemViewAll(int index, FaqTips listData, List<FaqTips> listDataData,
      BookMarkController logic) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.detail,
                arguments: [true, listDataData, index, null])!
            .then((value) {
          logic.getBookMarkData();
        });
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
            ),
            Expanded(
              child: Text(
                listData.title.toString(),
                style: TextStyle(
                  fontFamily: Font.poppins,
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

  _separatorListItemViewAll(BuildContext context, int index) {
    if ((index + 1) % 3 == 0) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: Sizes.height_0_7),
        height: Get.height * 0.1,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: CColor.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black)),
        child: /*(Debug.adType == Debug.adGoogleType &&
                Debug.isShowAd &&
                Debug.isShowBanner)
            ? NativeInlinePageBanner(context: context)
            : const FacebookBannerNative(),*/
            const Text(
          "Banner Native",
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Container();
    }
  }
}
