import 'package:app/app/data/data.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuhtMiddleware extends GetMiddleware {
  @override
  int? get priority => 2;
  final presistentData = PresistentData();

  bool isAuthenticated() {
    if (presistentData.getAuthToken() != null) {
      if (presistentData.getAuthToken()!.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  @override
  RouteSettings? redirect(String? route) {
    if (!isAuthenticated()) {
      return RouteSettings(name: Routes.LOGIN);
    }
    return super.redirect(route);
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}
