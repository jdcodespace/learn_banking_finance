import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/sizer_utils.dart';

import '../../../routes/app_routes.dart';
import '../controllers/list_of_task_controller.dart';

class ListOfTaskScreen extends StatelessWidget {
  const ListOfTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListOfTaskController>(builder: (logic) {
      return Scaffold(
        backgroundColor: CColor.white,
        body: SafeArea(
          child: Column(
            children: [
              _appBar(logic, context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(),
                      _widgetViewAll(logic),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _appBar(ListOfTaskController logic, BuildContext context) {
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

  _widgetViewAll(ListOfTaskController logic) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Sizes.width_3, vertical: Sizes.height_2),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _listItemViewAll(index, logic);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: logic.dataList[0].detail![logic.mainIndex].dataList!.length,
        scrollDirection: Axis.vertical,
      ),
    );
  }

  _listItemViewAll(int index, ListOfTaskController logic) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.detail,
            arguments: [false,logic.dataList, logic.mainIndex,index]);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Sizes.height_0_7),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: CColor.backgroundColor,
          borderRadius: BorderRadius.circular(10),
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
            Expanded(
              child: Text(
                logic
                    .dataList[0].detail![logic.mainIndex].dataList![index].title
                    .toString(),
                style: TextStyle(
                  color: CColor.black,
                  fontSize: FontSize.size_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _header() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.width_3),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: Sizes.height_5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CColor.backgroundColor,
      ),
      child: Image.asset(
        "assets/images/ic_bank.png",
        height: Sizes.height_8,
        width: Sizes.height_8,
      ),
    );
  }
}
