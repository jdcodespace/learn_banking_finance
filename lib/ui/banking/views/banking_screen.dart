import 'package:flutter/material.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/ui/banking/controllers/banking_controller.dart';
import 'package:learn_banking_finance/ui/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/sizer_utils.dart';

class BankingScreen extends StatelessWidget {
  const BankingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BankingController>(builder: (logic) {
      return Scaffold(
        key: logic.scaffoldKey,
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
                      _firstViewHeader(),
                      _widgetBlogNews(logic),
                      _widgetLearnBanking(logic),
                      _widgetFinanceLearn(logic),
                      _widgetSavingAccount(logic),
                      _widgetPersonalLoan(logic),
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

  Widget _appBar(BankingController logic, BuildContext context) {
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
                  logic.categoryFinanceClass!.title.toString(),
                  style: TextStyle(
                    color: CColor.black,
                    fontSize: FontSize.size_12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          Icon(
            Icons.arrow_back_ios_new_rounded,
            size: Sizes.height_2,
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
                    "txtBankingFinance".tr,
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
                      "txtBankingFinanceDesc".tr,
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

  /// ****************************Blog and news section*****************************
  _widgetBlogNews(BankingController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: Sizes.width_5,
                  top: Sizes.height_2,
                ),
                child: Text(
                  "txtBlogNews".tr,
                  style: TextStyle(
                    color: CColor.black,
                    fontSize: FontSize.size_12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.viewAll, arguments: ["txtBlogNews".tr]);
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: Sizes.width_5,
                  top: Sizes.height_2,
                ),
                child: Text(
                  "txtViewAll".tr,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: CColor.black,
                    fontSize: FontSize.size_10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.listOfTask,arguments: [logic.blogData,logic.title,0]);
          },
          child: Container(
            width: double.infinity,
            height: Sizes.height_20,
            margin: EdgeInsets.symmetric(
                horizontal: Sizes.width_3, vertical: Sizes.height_2),
            padding: EdgeInsets.all(Sizes.width_5),
            decoration: BoxDecoration(
                color: CColor.backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    "assets/images/ic_bank.png",
                    height: Sizes.height_8,
                    width: Sizes.height_8,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Sizes.height_2),
                  child: Text(
                    logic.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: CColor.black,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize.size_10,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// ****************************Learn banking section*****************************
  _widgetLearnBanking(BankingController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: Sizes.width_5,
            top: Sizes.height_2,
          ),
          child: Text(
            "txtLearnBanking".tr,
            style: TextStyle(
              color: CColor.black,
              fontSize: FontSize.size_12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Sizes.width_3, vertical: Sizes.height_2),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: logic.learnBankingData[0].detail!.length,
            itemBuilder: (context, index) {
              return _listItemLearnBanking(index);
            },
          ),
        )
      ],
    );
  }

  _listItemLearnBanking(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: Sizes.width_40,
        height: 150,
        // margin: EdgeInsets.symmetric(horizontal: Sizes.width_1),
        padding: EdgeInsets.all(Sizes.width_5),
        decoration: BoxDecoration(
            color: CColor.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                "assets/images/ic_bank.png",
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Sizes.height_2),
              child: Text(
                overflow: TextOverflow.ellipsis,
                "title",
                style: TextStyle(
                  color: CColor.black,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.size_10,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ****************************Finance guide*****************************
  _widgetFinanceLearn(BankingController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: Sizes.width_5,
            top: Sizes.height_2,
          ),
          child: Text(
            "txtFinanceGuide".tr,
            style: TextStyle(
              color: CColor.black,
              fontSize: FontSize.size_12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Sizes.width_3, vertical: Sizes.height_2),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              return _listItemLearnFinance(index);
            },
          ),
        )
      ],
    );
  }

  _listItemLearnFinance(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: Sizes.width_40,
        height: 150,
        // margin: EdgeInsets.symmetric(horizontal: Sizes.width_1),
        padding: EdgeInsets.all(Sizes.width_5),
        decoration: BoxDecoration(
            color: CColor.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                "assets/images/ic_bank.png",
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Sizes.height_2),
              child: Text(
                overflow: TextOverflow.ellipsis,
                "title",
                style: TextStyle(
                  color: CColor.black,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.size_10,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ****************************Saving account*****************************
  _widgetSavingAccount(BankingController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: Sizes.width_5,
                  top: Sizes.height_2,
                ),
                child: Text(
                  "txtSavingAccount".tr,
                  style: TextStyle(
                    color: CColor.black,
                    fontSize: FontSize.size_12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                right: Sizes.width_5,
                top: Sizes.height_2,
              ),
              child: Text(
                "txtViewAll".tr,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: CColor.black,
                  fontSize: FontSize.size_10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Sizes.width_3, vertical: Sizes.height_2),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _listItemSavingAccount(index);
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            scrollDirection: Axis.vertical,
          ),
        )
      ],
    );
  }

  _listItemSavingAccount(int index) {
    return Container(
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
          Text(
            "Saving account basic",
            style: TextStyle(
              color: CColor.black,
              fontSize: FontSize.size_12,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  /// ****************************Personal load guide*****************************
  _widgetPersonalLoan(BankingController logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: Sizes.width_5,
                  top: Sizes.height_2,
                ),
                child: Text(
                  "txtPersonalLoan".tr,
                  style: TextStyle(
                    color: CColor.black,
                    fontSize: FontSize.size_12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                right: Sizes.width_5,
                top: Sizes.height_2,
              ),
              child: Text(
                "txtViewAll".tr,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: CColor.black,
                  fontSize: FontSize.size_10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Sizes.width_3, vertical: Sizes.height_2),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              return _listItemPersonalLoan(index);
            },
          ),
        )
      ],
    );
  }

  _listItemPersonalLoan(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: Sizes.width_40,
        height: 150,
        // margin: EdgeInsets.symmetric(horizontal: Sizes.width_1),
        padding: EdgeInsets.all(Sizes.width_5),
        decoration: BoxDecoration(
            color: CColor.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                "assets/images/ic_bank.png",
                height: Sizes.height_8,
                width: Sizes.height_8,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Sizes.height_2),
              child: Text(
                overflow: TextOverflow.ellipsis,
                "title",
                style: TextStyle(
                  color: CColor.black,
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.size_10,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
