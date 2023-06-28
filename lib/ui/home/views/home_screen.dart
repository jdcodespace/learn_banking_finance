import 'package:flutter/material.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/ui/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/constant.dart';
import 'package:learn_banking_finance/utils/sizer_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (logic) {
      return Scaffold(
        key: logic.scaffoldKey,
        backgroundColor: CColor.white,
        drawer: _widgetDrawer(logic),
        body: SafeArea(
          child: GetBuilder<HomeController>(
            builder: (logic) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _appBar(logic, context),
                          _firstViewHeader(),
                          Container(
                            margin: EdgeInsets.only(
                              left: Sizes.width_5,
                              top: Sizes.height_2,
                            ),
                            child: Text(
                              "txtFinanceCategory".tr,
                              style: TextStyle(
                                color: CColor.black,
                                fontSize: FontSize.size_12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          _widgetCategoryFinance(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 1),
                    decoration: BoxDecoration(
                        color: CColor.opacityBlack10,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: CColor.black, width: 2)),
                    height: 200,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text("Small native ad"),
                  )
                ],
              );
            },
          ),
        ),
      );
    });
  }

  Widget _appBar(HomeController logic, BuildContext context) {
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
              logic.scaffoldKey.currentState!.openDrawer();
            },
            child: const Icon(Icons.menu_rounded),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: Sizes.width_4,
              ),
              child: Text(
                "appName".tr,
                style: TextStyle(
                  color: CColor.black,
                  fontSize: FontSize.size_12,
                  fontWeight: FontWeight.w800,
                ),
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
          left: Sizes.width_3, top: Sizes.height_5, bottom: Sizes.height_5),
      child: Row(
        children: [
          Image.asset(
            "assets/images/ic_bank.png",
            height: Sizes.height_9,
            width: Sizes.height_9,
          ),
          Container(
            margin: EdgeInsets.only(left: Sizes.width_3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "txtFinance".tr,
                  style: TextStyle(
                    color: CColor.black,
                    fontSize: FontSize.size_12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Sizes.height_1),
                  child: Text(
                    "txtFinanceDesc".tr,
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
        ],
      ),
    );
  }

  _widgetCategoryFinance() {
    return _listOfCategory();
  }

  _listOfCategory() {
    return GetBuilder<HomeController>(builder: (logic) {
      return SizedBox(
        height: Sizes.height_20,
        child: ListView.builder(
          padding: EdgeInsets.only(
            left: Sizes.width_2,
            top: Sizes.height_2,
            right: Sizes.width_2,
          ),
          itemBuilder: (context, index) {
            return _itemOfCategory(index, logic.categoryListData[index]);
          },
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: false,
          itemCount: logic.categoryListData.length,
          scrollDirection: Axis.horizontal,
        ),
      );
    });
  }

  _itemOfCategory(int index, CategoryFinanceClass categoryListData) {
    return InkWell(
      onTap: () {
        /*if(categoryListData.screenName != ""){
          Get.toNamed(categoryListData.screenName.toString(),arguments: [categoryListData]);
        }*/
        Get.toNamed(AppRoutes.detail);
      },
      child: Container(
        width: Sizes.width_40,
        margin: EdgeInsets.symmetric(horizontal: Sizes.width_1),
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
                categoryListData.title.toString(),
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


  /*Drawer section*/
  _widgetDrawer(HomeController logic) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: CColor.backgroundColor,
            ),
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
                  margin: EdgeInsets.only(
                      top: Sizes.height_2, bottom: Sizes.height_2),
                  child: Text(
                    'appName'.tr,
                    style: TextStyle(
                      color: CColor.black,
                      fontWeight: FontWeight.w700,
                      fontSize: FontSize.size_12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _listOfDrawerMenu(logic)
        ],
      ),
    );
  }

  _listOfDrawerMenu(HomeController logic) {
    return ListView.builder(
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return _itemMenu(index, logic.listData[index]);
        },
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: logic.listData.length,
        scrollDirection: Axis.vertical);
  }

  _itemMenu(int index, ItemMenuClass listData) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        margin: EdgeInsets.only(top: Sizes.height_3),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: Sizes.width_4, right: Sizes.width_2),
              child: listData.icon,
            ),
            Container(
              margin: EdgeInsets.only(
                left: Sizes.width_2,
              ),
              child: Expanded(
                child: Text(
                  listData.title.toString(),
                  style: TextStyle(
                    color: CColor.black,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.size_10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemMenuClass {
  Icon? icon;
  String? title;

  ItemMenuClass(this.icon, this.title);
}

class CategoryFinanceClass {
  String? image;
  String? title;
  String? screenName;

  CategoryFinanceClass(this.image, this.title,this.screenName);
}