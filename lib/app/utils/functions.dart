import 'dart:io';

import 'package:app/app/utils/utils.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class Functions {
  static final player = AudioPlayer();

  static getTranslate({required String enValue, required String arValue}) =>
      Get.locale?.languageCode.compareTo('ar') == 0 ? arValue : enValue;

  static showSnackBar(String title, String message) {}

  static String moneyFormat(String price) {
    double p;
    try {
      p = double.parse(price);
    } catch (e) {
      p = 0;
    }

    if (p == 0) {
      return '00.00';
    }

    MoneyFormatter fmf = MoneyFormatter(amount: p);

    return fmf.output.nonSymbol;

    // price = p != 0 ? double.parse(price).toString() : '0';
    // if (p == 0) {
    //   return '0.00';
    // }

    // if (price.length > 2) {
    //   var value = price;
    //   value = value.replaceAll(RegExp(r'\D'), '');
    //   value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    //   return value;
    // }
    // return price;
  }

  static String getUserAvatar(String avatar) {
    return EndPoints.userAvatarUrl() + avatar;
  }

  static String formatPercent(double number) {
    if (number == 0) {
      return '00.00';
    }
    int decimalPlaces = number.toString().split(".")[1].length;
    return number.toStringAsFixed(decimalPlaces > 2 ? 2 : decimalPlaces);
  }

  static String maskString(String? s) {
    if (s == null) {
      return '';
    }
    return '****** ' + s.substring(s.length > 4 ? s.length - 4 : s.length);
  }

  static String fullname(String? firstname, String? lastname) {
    return (firstname ?? '') + ' ' + (lastname ?? '');
  }

  static String getAmountOperation(
      num amount, num dollarAmount, String? currency) {
    if (currency == null) {
      return '\$ ' + moneyFormat(dollarAmount.toString());
    }
    return currency + ' ' + moneyFormat(amount.toString());
  }

  static String getAmountReport(double amount) {
    return Get.locale?.languageCode.compareTo('ar') == 0
        ? moneyFormat(amount.toString()) + ' \$'
        : '\$ ' + moneyFormat(amount.toString());
  }

  static String getLatestMessage(bool isAdmin, String message) {
    return isAdmin ? message : 'latest_message'.trParams({'message': message});
  }

  static requestFilePermission() async {
    // Check for relevant permissions.
    if (Platform.isIOS) {
      bool photos = await Permission.photos.status.isGranted;
      if (photos) {
        return true;
      } else {
        return await Permission.photos.request().isGranted;
      }
    } else {
      bool storage = true;
      bool videos = true;
      bool photos = true;

      // Only check for storage < Android 13
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        print('sdk > 33');
        videos = await Permission.videos.status.isGranted;
        photos = await Permission.photos.status.isGranted;

        if (await Permission.videos.isPermanentlyDenied ||
            await Permission.photos.isPermanentlyDenied) {
          openAppSettings();
        }
      } else {
        storage = await Permission.storage.status.isGranted;
        if (await Permission.storage.isPermanentlyDenied) {
          openAppSettings();
        }
      }

      if (storage && videos && photos) {
        return true;
      } else {
        print('request per');
        return await Permission.videos.request().isGranted &&
            await Permission.photos.request().isGranted;
      }
    }
  }

  static Future<bool> androidSdkAbove33() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      return true;
    }
    return false;
  }

  static Future<void> downloadFile(String url, [bool isPdf = false]) async {
    final permission = await Functions.requestFilePermission();
    if (!permission) {
      print(permission);
      Get.showSnackbar(GetSnackBar(
        title: 'fail'.tr,
        message: 'must_accept_permission'.tr,
        duration: const Duration(seconds: defaultSnackbarDuration),
      ));
      return;
    }
    var dir = await DownloadsPathProvider.downloadsDirectory;
    if (dir != null) {
      String name = url.substring(url.lastIndexOf('/') + 1, url.length);
      String pdfName = idGenerator() + '.pdf';
      String savename = isPdf ? pdfName : name;
      String savePath = dir.path + "/$savename";
      print(savename);

      deleteFile(File(savePath));
      //output:  /storage/emulated/0/Download/banner.png

      try {
        Get.showSnackbar(GetSnackBar(
          title: 'downloading'.tr,
          message: 'downloading_in_progress'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
        await Dio().download(url, savePath,
            onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
            //you can build progressbar feature too
          }
        });
        print("File is saved to download folder.");
        Get.showSnackbar(GetSnackBar(
          title: 'success'.tr,
          message: isPdf ? 'pdf_saved'.tr : 'photo_saved'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
      } on DioError catch (e) {
        print(e);
        Get.showSnackbar(GetSnackBar(
          title: 'fail'.tr,
          message: 'something_happened'.tr,
          duration: const Duration(seconds: defaultSnackbarDuration),
        ));
      } on FileSystemException catch (e) {
        print(e);
        if (e.osError?.errorCode == 17) {
          Get.showSnackbar(GetSnackBar(
            title: 'fail'.tr,
            message: 'something_happened'.tr,
            duration: const Duration(seconds: defaultSnackbarDuration),
          ));
        }
      }
    }
  }

  static Future<int> deleteFile(File file) async {
    try {
      print(await file.delete());
      print('deleted file');
      return 1;
    } catch (e) {
      return 0;
    }
  }

  static String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  static void playSendButtonSound() {
    player.play(AssetSource('sounds/send-click.wav'));
  }

  static void playMessagePopUpSound() {
    player.play(AssetSource('sounds/message-pop.mp3'));
  }

  static String reverseText(String text) {
    final chars = text.split('');

    return chars.reversed.join('');
  }

  static String getDateStyle() {
    return Get.locale?.languageCode.compareTo('ar') == 0
        ? 'yyyy/MM/dd'
        : 'dd/MM/yyyy';
  }

  static EdgeInsets getSpacingBasedOnLang(value) {
    return Get.locale?.languageCode.compareTo('ar') == 0
        ? EdgeInsets.only(left: value)
        : EdgeInsets.only(right: value);
  }

  static bool isMobileNumberValid(String? phoneNumber) {
    final frPhone = PhoneNumber.parse(phoneNumber ?? '');
    print(frPhone.isValid(type: PhoneNumberType.mobile));

    return !frPhone.isValid(type: PhoneNumberType.mobile);
  }
}

String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '.'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', ',', '٫'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(farsi[i], english[i]);
  }

  return input;
}

bool isValidNumber(String input) {
  RegExp reg = RegExp(r'^-?\d*\.?\d*$');
  return reg.hasMatch(input);
}

class DigitPersianFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String persianInput = newValue.text.toEnglishDigit();
    if (newValue.text.contains(',') || newValue.text.contains('٫')) {
      persianInput = replaceFarsiNumber(persianInput);
    }
    int selectionIndex = newValue.selection.end;
    return newValue.copyWith(
      text: persianInput.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
