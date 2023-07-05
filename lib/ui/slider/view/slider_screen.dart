import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/utils/preference.dart';

import '../../../facebook_ads/native/facebook_native_small.dart';
import '../../../google_ads/native/native_small_page.dart';
import '../../../offline/offline_screen.dart';
import '../../../utils/color.dart';
import '../../../utils/debug.dart';
import '../../../utils/font.dart';
import '../../../utils/sizer_utils.dart';
import '../controller/slider_controller.dart';

class SliderScreen extends StatelessWidget {
  const SliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderController>(builder: (logic) {
      return Scaffold(
        backgroundColor: CColor.white,
        body: SafeArea(
          child: logic.string == "Offline"
              ? OfflineScreen()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.5,
                      child: PageView.builder(
                        itemCount: logic.sliderData.length,
                        controller: logic.pageController,
                        onPageChanged: (value) {
                          logic.changeIndex(value);
                        },
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Get.height * 0.45,
                                width: Get.width,
                                // child: Image.asset(
                                //   "assets/images/ic_bank.png",
                                // ),
                                child: Image.network(
                                    logic.sliderData[index].image.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    logic.sliderData[index].desc.toString()),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          DotsIndicator(
                            dotsCount: logic.sliderData.length,
                            position: logic.selectedIndex.value.toDouble(),
                            decorator: DotsDecorator(
                              size: const Size.square(9.0),
                              activeSize: const Size(22.0, 10.0),
                              activeColor: Colors.black,
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                 if (logic.selectedIndex.value == 1) {
                            Get.toNamed(AppRoutes.home);
                            Preference.shared.setBool(Preference.isLogin, true);
                          } else {
                                logic.pageController.nextPage(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeIn);
                                /*logic.pageController.animateToPage(
                                logic.selectedIndex.value++,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeIn);*/

                                }
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(
                                  fontFamily: Font.poppins,
                                  color: CColor.black,
                                  fontSize: FontSize.size_12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ))
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      // margin:  EdgeInsets.only(bottom: Get.height * 0.01),
                      decoration: BoxDecoration(
                        color: CColor.opacityBlack10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 200,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: (Debug.adType == Debug.adGoogleType &&
                              Debug.isShowAd &&
                              Debug.isNativeAd)
                          ? NativeInlinePageSmall(context: context)
                          : smallNativeAdFacebook(context),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}