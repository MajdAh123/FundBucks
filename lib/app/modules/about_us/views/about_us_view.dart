import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:open_store/open_store.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 90.h,
            color: mainColor,
            child: PageHeaderWidget(
              title: 'about'.tr,
              canBack: true,
              hasNotificationIcon: false,
              icon: const SizedBox(),
            ),
          ),
          ListView(
            shrinkWrap: true,
            primary: true,
            children: [
              Assets.images.svg.logo.svg(),
              // SizedBox(height: 5.h),
              Center(
                child: Text(
                  'app_name'.tr + ' v' + appVersion,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Divider(),
              SizedBox(height: 20.h),
              OptionItemWidget(
                title: 'email_us'.tr,
                haveIcon: true,
                icon: Iconify(
                  MaterialSymbols.attach_email_outline_sharp,
                  size: 25,
                  color: mainColor,
                ),
                onTap: () async {
                  await launchUrl(Uri.parse('mailto:support@fundbucks.com'));
                },
              ),
              OptionItemWidget(
                title: 'visit_our_website'.tr,
                haveIcon: true,
                icon: Iconify(
                  MaterialSymbols.web,
                  color: mainColor,
                  size: 25,
                ),
                onTap: () async {
                  await launchUrl(
                    Uri.parse('https://fundbucks.com/'),
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
              OptionItemWidget(
                  title: 'rate_us'.tr,
                  haveIcon: true,
                  icon: Iconify(
                    MaterialSymbols.star_outline_rounded,
                    // color: Colors.amber,
                    color: mainColor,
                    size: 25,
                  ),
                  onTap: () {
                    OpenStore.instance.open(
                      appStoreId: controller
                          .getAppleId(), // AppStore id of your app for iOS
                      androidAppBundleId:
                          'com.fundbucks.app', // Android app bundle package name
                    );
                  }),
              SizedBox(height: 70.h),
              // CircleAvatar(
              //   backgroundColor: Colors.white,
              //   child: Padding(
              //     padding: const EdgeInsets.all(2.0),
              //     child: IconButton(
              //       icon: Iconify(Logos.twitter),
              //       onPressed: () async {
              //         await launchUrl(
              //           Uri.parse('https://twitter.com/fundbucks'),
              //           mode: LaunchMode.externalApplication,
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
