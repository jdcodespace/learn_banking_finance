import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learn_banking_finance/webview/controller/webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../utils/color.dart';
import '../../utils/sizer_utils.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: CColor.white,
      ),
    );
    return Scaffold(
      body: GetBuilder<WebviewController>(
        builder: (logic) {
          return SafeArea(
            child: Column(
              children: [
                _appBar(logic, context),
                Expanded(
                  child: WebViewWidget(
                    controller: logic.controller,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _appBar(WebviewController logic, BuildContext context) {
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
                  "Privacy Policy",
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
}
