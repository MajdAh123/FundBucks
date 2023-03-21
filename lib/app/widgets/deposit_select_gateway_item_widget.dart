import 'package:app/app/utils/utils.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DepositSelectGatewayItemWidget extends StatelessWidget {
  final String? selected;
  final Function(String?) onClick;
  final String alias;
  final String title;
  final Widget icon;
  final int id;
  const DepositSelectGatewayItemWidget({
    Key? key,
    required this.selected,
    required this.onClick,
    required this.alias,
    required this.title,
    required this.icon,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 7.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.toNamed('/gateway-detail', arguments: [
                id,
              ]);
            },
            icon: Icon(
              Icons.info_outline_rounded,
              color: selected?.compareTo(alias) == 0
                  ? mainColor
                  : unselectedBottomBarItemColor,
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onClick(alias),
              child: Container(
                height: 52.h,
                width: 343.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: selected?.compareTo(alias) == 0
                        ? mainColor
                        : const Color.fromARGB(255, 218, 218, 218),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 8.w),
                    icon,
                    SizedBox(width: 10.9.w),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        //fontFamily: FontFamily.inter,
                        fontWeight: FontWeight.w500,
                        color: textFieldColor,
                      ),
                    ),
                    // SizedBox(width: 160.w),
                    const Spacer(),
                    Radio(
                      value: alias,
                      groupValue: selected,
                      activeColor: mainColor,
                      onChanged: onClick,
                    ),
                    SizedBox(width: 5.w),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
