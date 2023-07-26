import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/utils/preference.dart';
import '../../../offline/offline_screen.dart';
import '../../../utils/color.dart';
import '../../../utils/debug.dart';
import '../../../utils/font.dart';
import '../../../utils/sizer_utils.dart';
import '../../../utils/utils.dart';
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
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.59,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: Get.height * 0.5,
                                        width: Get.width,
                                        // child: Image.asset(
                                        //   "assets/images/ic_bank.png",
                                        // ),
                                        child: Image.network(
                                          logic.sliderData[index].image
                                              .toString(),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, right: 15, left: 15),
                                        child: Text(
                                          logic.sliderData[index].desc
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: Font.quattrocento,
                                            color: CColor.black,
                                            fontSize: FontSize.size_12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  DotsIndicator(
                                    dotsCount: logic.sliderData.length,
                                    position:
                                        logic.selectedIndex.value.toDouble(),
                                    decorator: DotsDecorator(
                                      size: const Size.square(9.0),
                                      // activeSize: const Size(22.0, 10.0),
                                      activeSize: const Size.square(9.0),
                                      activeColor: Colors.black,
                                      activeShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                      onPressed: () {
                                        if (logic.selectedIndex.value == 1) {
                                          Get.toNamed(AppRoutes.home);
                                          Preference.shared.setBool(
                                              Preference.isLogin, true);
                                        } else {
                                          logic.pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 250),
                                              curve: Curves.easeIn);
                                        }
                                      },
                                      child: Text(
                                        "Next",
                                        style: TextStyle(
                                          fontFamily: Font.quattrocento,
                                          color: CColor.black,
                                          fontSize: FontSize.size_13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        child: (Debug.isShowAd && Debug.isNativeAd)
                            ? Utils.smallNativeAd(logic.sliderAd, context)
                            : Container()),
                  ],
                ),
        ),
      );
    });
  }
}
