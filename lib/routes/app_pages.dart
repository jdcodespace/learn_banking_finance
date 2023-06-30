import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/ui/accounting/bindings/accounting_binding.dart';
import 'package:learn_banking_finance/ui/accounting/view/accounting_screen.dart';
import 'package:learn_banking_finance/ui/banking/bindings/banking_binding.dart';
import 'package:learn_banking_finance/ui/banking/views/banking_screen.dart';
import 'package:learn_banking_finance/ui/bookmarks/bindings/bookmarks_binding.dart';
import 'package:learn_banking_finance/ui/bookmarks/views/bookmarks_screen.dart';
import 'package:learn_banking_finance/ui/detail/bindings/detail_binding.dart';
import 'package:learn_banking_finance/ui/detail/views/detail_screen.dart';
import 'package:learn_banking_finance/ui/faq/bindings/faq_binding.dart';
import 'package:learn_banking_finance/ui/faq/controller/faq_controller.dart';
import 'package:learn_banking_finance/ui/faq/view/faq_screen.dart';
import 'package:learn_banking_finance/ui/home/bindings/home_binding.dart';
import 'package:learn_banking_finance/ui/home/views/home_screen.dart';
import 'package:learn_banking_finance/ui/listoftask/bindings/list_of_task_binding.dart';
import 'package:learn_banking_finance/ui/listoftask/views/list_of_task_screen.dart';
import 'package:learn_banking_finance/ui/tips/bindings/tips_binding.dart';
import 'package:learn_banking_finance/ui/tips/view/tips_screen.dart';
import 'package:learn_banking_finance/ui/viewall/views/view_all_screen.dart';
import 'package:sizer/sizer.dart';
import '../ui/viewall/bindings/view_all_binding.dart';
import '../utils/color.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.home,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: CColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: HomeScreen(),
          );
        },
      ),
      binding: HomeBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.banking,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: CColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: BankingScreen(),
          );
        },
      ),
      binding: BankingBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.viewAll,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: CColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: ViewAllScreen(),
          );
        },
      ),
      binding: ViewAllBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.listOfTask,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: CColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: ListOfTaskScreen(),
          );
        },
      ),
      binding: ListOfTaskBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.detail,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: CColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: DetailScreen(),
          );
        },
      ),
      binding: DetailBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.tips,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: CColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: TipsScreen(),
          );
        },
      ),
      binding: TipsBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.faq,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: CColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: FaqScreen(),
          );
        },
      ),
      binding: FaqBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.bookMarks,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: CColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: BookMarkScreen(),
          );
        },
      ),
      binding: BookMarksBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

    GetPage(
      name: AppRoutes.accounting,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: CColor.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: AccountingScreen(),
          );
        },
      ),
      binding: AccountingBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),

  ];
}
