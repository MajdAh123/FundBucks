import 'package:app/app/data/models/countryNationl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../theme_controller.dart';
import '../controllers/edit_profile_controller.dart';
import '../providers/user_provider.dart';

class CountriesPage extends StatelessWidget {
  const CountriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeController.to.isDarkMode.isTrue
            ? containerColorDarkTheme
            : Colors.white,
        appBar: AppBar(
          title: Text(
            "select_nationalty".tr,
            style: TextStyle(
                color: ThemeController.to.isDarkMode.isTrue
                    ? Colors.grey
                    : Colors.black),
          ),
          iconTheme: IconThemeData(
              color: ThemeController.to.isDarkMode.isTrue
                  ? Colors.grey
                  : Colors.black),
        ),
        body: GetBuilder<EditProfileController>(
            init: EditProfileController(userProvider: Get.find<UserProvider>()),
            builder: (controller) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ThemeController.to.getIsDarkMode
                                ? greyColor.withOpacity(.9)
                                : strokeColor,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "search_".tr,
                              hintStyle: TextStyle(color: Colors.grey)),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              controller.searchCountry = controller.allNational;
                            } else {
                              controller.searchCountry = controller
                                  .searchCountry
                                  .where((element) => element.countryName!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            }
                            controller.update();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.searchCountry.length,
                        itemBuilder: (context, index) {
                          CountryNational countryNational =
                              controller.searchCountry[index];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            child: InkWell(
                              onTap: () {
                                controller.nationalTextEditController.value
                                    .text = countryNational.countryName!;
                                controller.searchCountry =
                                    controller.allNational;

                                Get.back();
                                controller.update();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    countryNational.countryName!,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            ThemeController.to.isDarkMode.isTrue
                                                ? Colors.grey
                                                : Colors.black),
                                  ),
                                  Text(
                                    countryNational.countryCode!,
                                    style: TextStyle(
                                        color:
                                            ThemeController.to.isDarkMode.isTrue
                                                ? Colors.grey
                                                : Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )));
  }
}
