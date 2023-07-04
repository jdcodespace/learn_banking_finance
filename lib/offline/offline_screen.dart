import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/color.dart';
import '../ui/home/controllers/home_controller.dart';
import '../ui/home/views/home_screen.dart';
import '../utils/font.dart';

class OfflineScreen extends StatelessWidget {
  OfflineScreen({Key? key}) : super(key: key);

  final HomeController resumeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      Theme.of(context).secondaryHeaderColor == Colors.white
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarColor: const Color(0xff000000),
            )
          : SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: const Color(0xffecebf0),
            ),
    );

    /* return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {*/
    return SafeArea(
      child: Scaffold(
        backgroundColor: /*Theme.of(context).secondaryHeaderColor == Colors.white
            ? const Color(0xff000000)
            :*/ const Color(0xffecebf0),
        body: Center(
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icon/no_internet.svg",
                  // ignore: deprecated_member_use
                  color:/* Theme.of(context).secondaryHeaderColor == Colors.white
                      ? const Color(0xfff5f1f1)
                      :*/ const Color(0xff464646),
                  height: 120,
                  width: 150,
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.02),
                  child:   Text(
                    "Can't load page",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: Font.poppins,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.03),
                  child:  Text(
                    "No internet connection found.\nCheck your connection.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Font.poppins,
                      color: CColor.gray,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.09),
                  child: ElevatedButton(
                    onPressed: () {
                      GetBuilder<HomeController>(builder: (logic) {
                        return logic.string == "Offline"
                            ? OfflineScreen()
                            : const HomeScreen();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.02,
                        vertical: Get.height * 0.01,
                      ),
                      child:  Text(
                        "Try again",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: Font.poppins,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    /* });*/
  }
}
