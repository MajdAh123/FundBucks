import 'package:app/app/modules/lanuage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;

import 'package:get/get.dart';

import '../../generated/fonts.gen.dart';

class AwesomeSnackbarContent extends StatelessWidget {
  /// `IMPORTANT NOTE` for SnackBar properties before putting this in `content`
  /// backgroundColor: Colors.transparent
  /// behavior: SnackBarBehavior.floating
  /// elevation: 0.0

  /// /// `IMPORTANT NOTE` for MaterialBanner properties before putting this in `content`
  /// backgroundColor: Colors.transparent
  /// forceActionsBelow: true,
  /// elevation: 0.0
  /// [inMaterialBanner = true]

  /// title is the header String that will show on top
  final String title;

  /// message String is the body message which shows only 2 lines at max
  final String message;

  /// `optional` color of the SnackBar/MaterialBanner body
  final Color? color;

  /// contentType will reflect the overall theme of SnackBar/MaterialBanner: failure, success, help, warning
  final ContentType contentType;

  /// if you want to use this in materialBanner
  final bool inMaterialBanner;

  /// if you want to customize the font size of the title
  final double? titleFontSize;

  /// if you want to customize the font size of the message
  final double? messageFontSize;
  const AwesomeSnackbarContent({
    Key? key,
    this.color,
    this.titleFontSize,
    this.messageFontSize,
    required this.title,
    required this.message,
    required this.contentType,
    this.inMaterialBanner = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;
//  String fontFamily = getFontFamilyBasedOnLang();
    final size = MediaQuery.of(context).size;

    // screen dimensions
    bool isMobile = size.width <= 768;
    bool isTablet = size.width > 768 && size.width <= 992;

    /// for reflecting different color shades in the SnackBar
    final hsl = HSLColor.fromColor(color ?? contentType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    double horizontalPadding = 0.0;
    double leftSpace = size.width * 0.12;
    double rightSpace = size.width * 0.12;

    if (isMobile) {
      horizontalPadding = size.width * 0.01;
    } else if (isTablet) {
      leftSpace = size.width * 0.05;
      horizontalPadding = size.width * 0.2;
    } else {
      leftSpace = size.width * 0.05;
      horizontalPadding = size.width * 0.3;
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      height: size.height * 0.15,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          /// background container
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: color ?? contentType.color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          /// Splash SVG asset
          Positioned(
            bottom: 10,
            left: 10,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    // bottomLeft: Radius.circular(20),
                    ),
                child: ColorFiltered(
                    colorFilter:
                        _getColorFilter(hslDark.toColor(), ui.BlendMode.srcIn)!,
                    child: Image.asset(
                      AssetsPath.bubbles,
                      height: size.height * 0.05,
                      width: size.width * 0.13,
                      fit: BoxFit.cover,
                      // color: color,
                    ))

                //  SvgPicture.asset(
                //   AssetsPath.bubbles,
                //   // height: size.height * 0.06,
                //   // width: size.width * 0.05,
                //   // colorFilter:
                //   //     _getColorFilter(hslDark.toColor(), ui.BlendMode.srcIn),
                //   // package: 'awesome_snackbar_content',
                // ),
                ),
          ),

          // Bubble Icon
          Positioned(
            top: -size.height * 0.02,
            left: !isRTL
                ? leftSpace -
                    8 -
                    (isMobile ? size.width * 0.075 : size.width * 0.035)
                : null,
            right: isRTL
                ? rightSpace -
                    8 -
                    (isMobile ? size.width * 0.075 : size.width * 0.035)
                : null,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AssetsPath.back,
                  height: size.height * 0.06,
                  colorFilter:
                      _getColorFilter(hslDark.toColor(), ui.BlendMode.srcIn),
                  // package: 'awesome_snackbar_content',
                ),
                Positioned(
                  top: size.height * 0.015,
                  child: SvgPicture.asset(
                    assetSVG(contentType),
                    height: size.height * 0.022,
                    // package: 'awesome_snackbar_content',
                  ),
                )
              ],
            ),
          ),

          /// content
          Positioned.fill(
            left: isRTL ? size.width * 0.03 : leftSpace,
            right: isRTL ? rightSpace : size.width * 0.03,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// `title` parameter
                    Expanded(
                      flex: 3,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontFamily: Get.find<LanguageController>()
                                      .getLanguage()
                                      .compareTo('ar') ==
                                  0
                              ? FontFamily.tajawal
                              : FontFamily.inter,
                          fontSize: titleFontSize ??
                              (!isMobile
                                  ? size.height * 0.03
                                  : size.height * 0.025),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        if (inMaterialBanner) {
                          ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner();
                          return;
                        }
                        // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        // overlayEntry.remove();
                        // Get.back();

                        print("22222222222");
                      },
                      child: SvgPicture.asset(
                        AssetsPath.failure,
                        height: size.height * 0.022,
                        // package: 'awesome_snackbar_content',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),

                /// `message` body text parameter
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: messageFontSize ?? size.height * 0.016,
                      color: Colors.white,
                      fontFamily: Get.find<LanguageController>()
                                  .getLanguage()
                                  .compareTo('ar') ==
                              0
                          ? FontFamily.tajawal
                          : FontFamily.inter,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Reflecting proper icon based on the contentType
  String assetSVG(ContentType contentType) {
    switch (contentType) {
      case ContentType.failure:

        /// failure will show `CROSS`
        return AssetsPath.failure;
      case ContentType.success:

        /// success will show `CHECK`
        return AssetsPath.success;
      case ContentType.warning:

        /// warning will show `EXCLAMATION`
        return AssetsPath.warning;
      case ContentType.help:

        /// help will show `QUESTION MARK`
        return AssetsPath.help;
      default:
        return AssetsPath.failure;
    }
  }

  static ColorFilter? _getColorFilter(
          ui.Color? color, ui.BlendMode colorBlendMode) =>
      color == null ? null : ui.ColorFilter.mode(color, colorBlendMode);
}

class ContentType {
  /// message is `required` parameter
  final String message;

  /// color is optional, if provided null then `DefaultColors` will be used
  final Color? color;

  const ContentType(this.message, [this.color]);

  static const ContentType help = ContentType('help', DefaultColors.helpBlue);
  static const ContentType failure =
      ContentType('failure', DefaultColors.failureRed);
  static const ContentType success =
      ContentType('success', DefaultColors.successGreen);
  static const ContentType warning =
      ContentType('warning', DefaultColors.warningYellow);
}

class DefaultColors {
  /// help
  static const Color helpBlue = Color.fromARGB(255, 0, 170, 255);

  /// failure
  static const Color failureRed = Color.fromARGB(255, 255, 99, 120);

  /// success
  static const Color successGreen = Color(0xff2D6A4F);

  /// warning
  static const Color warningYellow = Colors.orange;
}

class AssetsPath {
  static const String help = 'assets/images/svg/types/help.svg';
  static const String failure = 'assets/images/svg/types/failure.svg';
  static const String success = 'assets/images/svg/types/success.svg';
  static const String warning = 'assets/images/svg/types/warning.svg';

  static const String back = 'assets/images/svg/back.svg';
  static const String bubbles = 'assets/images/png/snackbarLogo.png';
}
