import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/ui/tips/controller/tips_controller.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
import '../../../utils/sizer_utils.dart';

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
              return Column(
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
              Icons.arrow_back_ios_new_rounded,
              size: Sizes.height_3,
            ),
          ),
          Expanded(
            child: Text(
              "Tips",
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
                    "txtTips".tr,
                    style: TextStyle(
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
          return _listItemViewAll(index,logic);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:  logic.tipsData.length,
        scrollDirection: Axis.vertical,
      ),
    );
  }

  _listItemViewAll(int index,TipsController logic) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.detail,arguments: [true,logic.tipsData,index]);
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
                logic.tipsData[index].title.toString(),
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
