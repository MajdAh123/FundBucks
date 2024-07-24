import 'package:app/app/utils/constant.dart';
import 'package:app/app/widgets/snackBarCore.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
// import 'snackBarCore.dart';

// SnackBarWidget() {
//   final materialBanner = MaterialBanner(
//     /// need to set following properties for best effect of awesome_snackbar_content
//     elevation: 0,
//     backgroundColor: Colors.transparent,
//     forceActionsBelow: true,
//     content: AwesomeSnackbarContent(
//       title: 'Oh Hey!!',
//       message:
//           'This is an example error message that will be shown in the body of materialBanner!',

//       /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//       contentType: ContentType.success,
//       // to configure for material banner
//       inMaterialBanner: true,
//     ),
//     actions: const [SizedBox.shrink()],
//   );

//   ScaffoldMessenger.of(Get.context!)
//     ..hideCurrentMaterialBanner()
//     ..showMaterialBanner(materialBanner);
// }

SnackBarWidgetAwesome(String title, String massage, {void Function()? ontap}) {
  final snackBar = MaterialBanner(
    actions: const [SizedBox.shrink()],
    // duration: const Duration(seconds: defaultSnackbarDuration),
    // action: SnackBarAction(label: "", onPressed: onPressed),

    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    // hitTestBehavior: HitTestBehavior.deferToChild,
    // margin: EdgeInsets.only(top: 15),
    // behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: GestureDetector(
      onTap: ontap == null ? null : ontap,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: AwesomeSnackbarContent(
          messageFontSize: 12,
          color: Color.fromARGB(255, 0, 170, 255),
          title: title,
          message: massage,

          // svg: 'assets/images/svg/snackbarLogo.svg',
          // 'This is an example error message that will be shown in the body of snackbar!',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.help,
        ),
      ),
    ),
  );

  ScaffoldMessenger.of(Get.context!)
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(snackBar);
}

SnackBarWidgetAwesomeWarning(String title, String massage,
    {void Function()? ontap}) {
  final snackBar = SnackBar(
    duration: const Duration(seconds: defaultSnackbarDuration),
    // action: SnackBarAction(label: "", onPressed: onPressed),

    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    hitTestBehavior: HitTestBehavior.deferToChild,
    // margin: EdgeInsets.only(top: 15),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: GestureDetector(
      onTap: ontap == null ? null : ontap,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: AwesomeSnackbarContent(
          messageFontSize: 12,
          color: Color(0xffFCA652),
          title: title,
          message: massage,
          // svg: 'assets/images/svg/snackbarLogo.svg',
          // 'This is an example error message that will be shown in the body of snackbar!',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.warning,
        ),
      ),
    ),
  );

  ScaffoldMessenger.of(Get.context!)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

SnackBarWidgetAwesomeError(String title, String massage,
    {void Function()? ontap}) {
  final snackBar = SnackBar(
    duration: const Duration(seconds: defaultSnackbarDuration),
    // action: SnackBarAction(label: "", onPressed: onPressed),

    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    hitTestBehavior: HitTestBehavior.deferToChild,
    // margin: EdgeInsets.only(top: 15),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: GestureDetector(
      onTap: ontap == null ? null : ontap,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: AwesomeSnackbarContent(
          color: Color(0xffc72c41),
          // svg: 'assets/images/svg/snackbarLogo.svg',

          messageFontSize: 12,

          title: title,
          message: massage,

          // 'This is an example error message that will be shown in the body of snackbar!',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      ),
    ),
  );

  ScaffoldMessenger.of(Get.context!)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
