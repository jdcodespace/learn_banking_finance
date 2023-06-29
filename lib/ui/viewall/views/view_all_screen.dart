import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/sizer_utils.dart';

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
              return Column(
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
              Icons.arrow_back_ios_new_rounded,
              size: Sizes.height_2,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: Sizes.width_4,
              ),
              child: Center(
                child: Text(
                  logic.title,
                  style: TextStyle(
                    color: CColor.black,
                    fontSize: FontSize.size_12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  _widgetViewAll(ViewAllController logic) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Sizes.width_3, vertical: Sizes.height_2),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _listItemViewAll(index,logic);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: logic.blogData[0].detail!.length,
        scrollDirection: Axis.vertical,
      ),
    );
  }

  _listItemViewAll(int index,ViewAllController logic) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.listOfTask,arguments: [logic.blogData, logic.blogData[0].detail![index].title.toString(),index]);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Sizes.height_0_7),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: CColor.backgroundColor,
            borderRadius: BorderRadius.circular(10)
        ),
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
            Text(
              logic.blogData[0].detail![index].title.toString(),
              style: TextStyle(
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

}
