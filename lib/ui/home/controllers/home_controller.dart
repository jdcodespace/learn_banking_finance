import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color.dart';
import '../../../utils/sizer_utils.dart';
import '../views/home_screen.dart';

class HomeController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<ItemMenuClass> listData = [];
  List<CategoryFinanceClass> categoryListData = [];

  @override
  void onInit() {
    getDrawerListData();
    getCategoryListData();
    super.onInit();
  }

  getDrawerListData(){
    listData.add(ItemMenuClass(
        Icon(
          Icons.home_rounded,
          color: CColor.borderColor,
          size: Sizes.height_3,
        ),
        "txtHome".tr));
    listData.add(ItemMenuClass(
        Icon(
          Icons.bookmark_border_rounded,
          color: CColor.borderColor,
          size: Sizes.height_3,
        ),
        "txtBookMark".tr));
    listData.add(ItemMenuClass(
        Icon(
          Icons.lock_rounded,
          color: CColor.borderColor,
          size: Sizes.height_3,
        ),
        "txtPrivacyPolicy".tr));
    listData.add(ItemMenuClass(
        Icon(
          Icons.star_rate_rounded,
          color: CColor.borderColor,
          size: Sizes.height_3,
        ),
        "txtRateApp".tr));
    listData.add(ItemMenuClass(
        Icon(
          Icons.email_rounded,
          color: CColor.borderColor,
          size: Sizes.height_3,
        ),
        "txtFeedback".tr));
    listData.add(ItemMenuClass(
        Icon(
          Icons.thumb_up_rounded,
          color: CColor.borderColor,
          size: Sizes.height_3,
        ),
        "txtShareApp".tr));
  }

  void getCategoryListData() {
    categoryListData.add(CategoryFinanceClass("","txtCategoryBanking".tr,"/banking"));
    categoryListData.add(CategoryFinanceClass("","txtCategoryAccounting".tr,""));
    categoryListData.add(CategoryFinanceClass("","txtCategoryBookmarks".tr,""));
    categoryListData.add(CategoryFinanceClass("","txtCategoryTips".tr,""));
    categoryListData.add(CategoryFinanceClass("","txtCategoryFAQ".tr,""));
  }
}
