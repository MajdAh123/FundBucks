import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/generated/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:typewritertext/typewritertext.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          ThemeController.to.getIsDarkMode ? mainColorDarkTheme : mainColor,
      body: Center(
        child: AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            double centerPostin =
                Get.width - (Get.width * 0.16 + Get.width * 0.6);
            final double logoXPosition = MediaQuery.of(context).size.width *
                    (1.0 - controller.animation.value) -
                50; // Adjust positioning
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: logoXPosition + centerPostin,
                        child: Image.asset(
                          "assets/images/pngLogo.png",
                          height: Get.width * 0.12,
                          width: Get.width * 0.16,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        left: logoXPosition + centerPostin + Get.width * 0.16,
                        child: Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: TypeWriter(
                            controller: controller.writeController,
                            builder: (BuildContext, TypeWriterValue value) {
                              return Text(
                                value.text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Get.width * 0.1,
                                  fontFamily: FontFamily.inter,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              );
                            },

                            // controller.w,
                            // maintainSize: false,
                            // maxLines: 1,
                            // style: TextStyle(
                            //   color: Colors.white,
                            //   fontSize: 40,
                            //   fontFamily: FontFamily.inter,
                            //   fontWeight: FontWeight.bold,
                            //   fontStyle: FontStyle.italic,
                            // ),
                            // duration: const Duration(milliseconds: 200),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
