import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/constant.dart';
import 'package:learn_banking_finance/utils/debug.dart';
import 'package:learn_banking_finance/utils/sizer_utils.dart';

import '../controllers/detail_controller.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(builder: (logic) {
      return Scaffold(
        backgroundColor: CColor.white,
        body: SafeArea(
          child: GetBuilder<DetailController>(
            builder: (logic) {
              return Column(
                children: [
                  _appBar(logic, context),
                  _centerView(logic),
                  _nextPreviousButton(logic),
                ],
              );
            },
          ),
        ),
      );
    });
  }

  Widget _appBar(DetailController logic, BuildContext context) {
    return GetBuilder<DetailController>(
        id: Constant.idAppBar,
        builder: (logic) {
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
                "Detail",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CColor.black,
                  fontWeight: FontWeight.w700,
                  fontSize: FontSize.size_14,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                var currentPage = logic.pageController.page!.toInt();
                Debug.printLog("logic.pageController.initialPage......${logic.pageController.page}");
                // if(logic.isTips && logic.tipsData[logic.mainIndex].isMark){
                if(logic.isTips && logic.tipsData[currentPage].isMark){
                  logic.removeTipsBookMark();
                }else if(!logic.isTips && logic.bankData[0].detail![logic.mainIndex]
                    .dataList![currentPage].isMark){
                    // .dataList![logic.subIndex].isMark){
                  logic.removeBankDataBookMark();
                }else {
                  logic.addBookmarkData();
                }
              },
              child: Icon(
                    (!logic.isTips)
                        ? (logic.bankData.isNotEmpty &&
                                logic.bankData[0].detail![logic.mainIndex]
                                    .dataList![logic.subIndex].isMark
                            ? Icons.bookmark
                            : Icons.bookmark_border_rounded)
                        : (logic.isTips)
                            ? (logic.tipsData.isNotEmpty &&
                                    logic.tipsData[logic.mainIndex].isMark)
                                    // logic.tipsData[logic.pageController.page!.toInt()].isMark)
                                ? Icons.bookmark
                                : Icons.bookmark_border_rounded
                            : Icons.bookmark_border_rounded,
                    size: Sizes.height_3,
              ),
            ),
          ],
        ),
      );
    });
  }

  _centerView(DetailController logic) {
    return Expanded(
      child: PageView.builder(
        controller: logic.pageController,
        itemBuilder: (context, index) {
          return _descriptionItem(logic, index);
        },
        itemCount: (logic.isTips == true)
            ? logic.tipsData.length
            : (logic.bankData.isNotEmpty) ? logic.bankData[0].detail![logic
            .mainIndex].dataList!.length : 0,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          logic.changedValuesForPage(value);
        },
      ),
    );
  }

  _descriptionItem(DetailController logic, int index) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: Get.height * 0.21,
            color: CColor.backgroundColor,
            child: Text(
              (logic.isTips == true)
                  ? logic.tipsData[index].title.toString()
                  : logic.bankData[0].detail![logic.mainIndex]
                  .dataList![index].title
                  .toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontSize.size_20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: Get.height * 0.25,
              decoration: BoxDecoration(
                color: CColor.backgroundColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black),
              ),
              child: const Center(child: Text("Small native ad")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              (logic.isTips == true)
                  ? logic.tipsData[index].desc.toString()
                  : logic.bankData[0].detail![logic.mainIndex].dataList![index]
                  .desc
                  .toString(),
              style: TextStyle(
                fontSize: FontSize.size_12,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }

  _nextPreviousButton(DetailController logic) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {

              logic.nextPrevPage(false);
              /*if((logic.isTips && logic.tipsData.length > logic.mainIndex) || (!logic.isTips && logic.bankData.length > logic.mainIndex)) {
                logic.onChangedPageValue(false);
              }*/
            },
            child: const CircleAvatar(
              maxRadius: 30,
              backgroundColor: CColor.backgroundColor,
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
             /* logic.pageController.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn);*/
              logic.nextPrevPage(true);
              /* if((logic.isTips && logic.tipsData.length > logic.mainIndex) || (!logic.isTips && logic.bankData.length > logic.mainIndex)) {
                logic.onChangedPageValue(true);
              }*/
            },
            child: const CircleAvatar(
              maxRadius: 30,
              backgroundColor: CColor.backgroundColor,
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
