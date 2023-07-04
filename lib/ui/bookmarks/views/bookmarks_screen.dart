import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/ui/bookmarks/controller/bookmarks_controller.dart';
import 'package:learn_banking_finance/ui/detail/controllers/detail_controller.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/sizer_utils.dart';

import '../../../datamodel/bank_data.dart';

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
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Sizes.width_3, vertical: Sizes.height_2),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _listItemViewAll(index,logic.listData[index],logic.listData,logic);
          },
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: logic.listData.length,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }

  _listItemViewAll(int index, FaqTips listData, List<FaqTips> listDataData, BookMarkController logic) {
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
                  color: CColor.black,
                  fontSize: FontSize.size_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_outlined,
            size: 17)
          ],
        ),
      ),
    );
  }
}
