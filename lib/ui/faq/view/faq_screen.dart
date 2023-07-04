import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/ui/faq/controller/faq_controller.dart';
import '../../../google_ads/inter/inter_ad.dart';
import '../../../offline/offline_screen.dart';
import '../../../utils/color.dart';
import '../../../utils/font.dart';
import '../../../utils/sizer_utils.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FaqController>(builder: (logic) {
      return Scaffold(
        backgroundColor: CColor.white,
        body: SafeArea(
          child: GetBuilder<FaqController>(
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
                      ],
                    );
            },
          ),
        ),
      );
    });
  }

  Widget _appBar(FaqController logic, BuildContext context) {
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
              "FAQ's",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Font.poppins,
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
                    "txtFaq".tr,
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
                      "txtFaqDesc".tr,
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

  _widgetTipsAll(FaqController logic) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Sizes.width_3, vertical: Sizes.height_2),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return _listItemFaqAll(index, logic, context);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: logic.faqData.length,
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, int index) {
          return _separatorListItemViewAll(context, index);
        },
      ),
    );
  }

  _listItemFaqAll(int index, FaqController logic, BuildContext context) {
    return InkWell(
      onTap: () {
        logic.dataVisible(index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Sizes.height_0_7),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: CColor.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
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
                    logic.faqData[index].title.toString(),
                    style: TextStyle(
                      fontFamily: Font.poppins,
                      color: CColor.black,
                      fontSize: FontSize.size_12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    InterstitialAdClass.showInterstitialAdInterCount(context,
                        () {
                      logic.dataVisible(index);
                    });
                  },
                  child: Icon(
                    (logic.faqData[index].isFaqShow)
                        ? Icons.keyboard_arrow_up_outlined
                        : Icons.keyboard_arrow_down_outlined,
                    size: 25,
                  ),
                )
              ],
            ),
            Visibility(
              visible: logic.faqData[index].isFaqShow,
              child: Text(
                logic.faqData[index].desc.toString(),
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontSize: FontSize.size_12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
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
