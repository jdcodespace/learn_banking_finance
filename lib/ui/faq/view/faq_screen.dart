import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/ui/faq/controller/faq_controller.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
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
              Icons.arrow_back_ios_new_rounded,
              size: Sizes.height_3,
            ),
          ),
          Expanded(
            child: Text(
              "FAQ's",
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
                    "txtFaq".tr,
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
                      "txtFaqDesc".tr,
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

  _widgetTipsAll(FaqController logic) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Sizes.width_3, vertical: Sizes.height_2),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _listItemFaqAll(index, logic);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        scrollDirection: Axis.vertical,
      ),
    );
  }

  _listItemFaqAll(int index, FaqController logic) {
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
                    "Saving account basic",
                    style: TextStyle(
                      color: CColor.black,
                      fontSize: FontSize.size_12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    logic.dataVisible(index);
                  },
                  child: Icon(
                    (logic.isVisible == true)
                        ? Icons.keyboard_arrow_up_outlined
                        : Icons.keyboard_arrow_down_outlined,
                    size: 25,
                  ),
                )
              ],
            ),
            Visibility(
              visible: (index == logic.selectedIndex) ? logic.isVisible : false,
              child: Text(
                "Bridging finance refers to a short-term loan or financial arrangement that is typically used to 'bridge' a gap between the need for immediate funds and the availability of more permanent financing. It is often used in real estate transactions when there is a delay in the completion of a sale or the availability of long-term financing.Bridging finance is commonly used when a property purchase is involved, but the buyer needs immediate funds to secure the property or cover other costs. It allows the buyer to proceed with the purchase before selling an existing property or finalizing long-term financing. Once the sale or long-term financing is complete, the bridging loan is repaid.",
                style: TextStyle(
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
}
