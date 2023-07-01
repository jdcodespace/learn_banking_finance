import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/ui/bookmarks/controller/bookmarks_controller.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/sizer_utils.dart';

import '../../../facebook_ads/inter/interAd.dart';
import '../../../offline/offline_screen.dart';

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
                  :Column(
                children: [
                  _appBar(logic, context),
                  _widgetViewAll(logic),
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
              Icons.arrow_back_ios_new_rounded,
              size: Sizes.height_3,
            ),
          ),
          Expanded(
            child: Text(
              "Bookmarks",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: CColor.black,
                fontWeight: FontWeight.w700,
                fontSize: FontSize.size_14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _widgetViewAll(BookMarkController logic) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Sizes.width_3, vertical: Sizes.height_2),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _listItemViewAll(index, context);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        scrollDirection: Axis.vertical,
      ),
    );
  }

  _listItemViewAll(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        InterstitialAdClass.showInterstitialAdInterCount(context, () {
          Get.toNamed(AppRoutes.detail);
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
                "Saving account basic",
                style: TextStyle(
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
}
