import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/home/controllers/operation_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WithdrawFormWidget extends GetView<OperationController> {
  const WithdrawFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: controller.getWithdrawFormKey(),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller:
                        controller.withdrawBankTextEditingController.value,
                    cursorColor: mainColor,
                    readOnly: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'required_field'.trParams({
                          'name': 'select_bank'.tr,
                        });
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      hintText: controller.getBankNameChoice(),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: strokeColor,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: strokeColor,
                          width: 1.0,
                        ),
                      ),
                      hintStyle: TextStyle(
                        //fontFamily: FontFamily.inter,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: controller.checkIfBankingDetailsExists()
                            ? Colors.black
                            : secondaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: strokeColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () =>
                        Get.toNamed('/edit-profile', arguments: [true]),
                    icon: Icon(
                      Icons.edit_note_rounded,
                      color: mainColor,
                    )),
              ],
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: controller.withdrawAmountTextEditingController.value,
              cursorColor: mainColor,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'required_field'.trParams({
                    'name': 'amount'.tr,
                  });
                }
                if (controller.checkWithdrawAmount()) {
                  return 'withdraw_max_amount'.tr;
                }
                // withdraw_max_amount
                return null;
              },
              decoration: InputDecoration(
                errorMaxLines: 2,
                hintText: 'amount'.tr,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: strokeColor,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: strokeColor,
                    width: 1.0,
                  ),
                ),
                hintStyle: TextStyle(
                  //fontFamily: FontFamily.inter,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: strokeColor,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              // height: 52.h,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                border: Border.all(color: strokeColor),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  // value: 'gender',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'required_field'.trParams({
                        'name': 'currency'.tr,
                      });
                    }
                    return null;
                  },
                  value: controller.getDepositCurrencySelect(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  decoration: InputDecoration(
                    constraints: BoxConstraints(minHeight: 52.h),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    // errorBorder:
                    //     UnderlineInputBorder(borderSide: BorderSide(width: 0)),
                    // focusedErrorBorder:
                    //     UnderlineInputBorder(borderSide: BorderSide(width: 0)),
                  ),
                  hint: Text(
                    'currency'.tr,
                    style: TextStyle(
                      fontFamily: Get.locale?.languageCode.compareTo('ar') == 0
                          ? FontFamily.tajawal
                          : FontFamily.inter,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: textFieldColor,
                    ),
                  ),
                  style: TextStyle(
                    //fontFamily: FontFamily.inter,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                  isDense: true,
                  isExpanded: true,
                  items: [
                    ...controller
                        .getCurrencies()
                        .map(
                          (Currency e) => DropdownMenuItem<String>(
                            child: Text(
                              Get.locale?.languageCode.compareTo('ar') == 0
                                  ? e.currencyId!
                                  : e.currencySign!,
                              style: TextStyle(
                                fontFamily:
                                    Get.locale?.languageCode.compareTo('ar') ==
                                            0
                                        ? FontFamily.tajawal
                                        : FontFamily.inter,
                              ),
                            ),
                            value: e.currencyId!,
                          ),
                        )
                        .toList(),
                  ],
                  onChanged: controller.setCurrencySelect,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Container(
              margin: EdgeInsets.only(left: 16.w, right: 15.w),
              child: TextButton(
                onPressed: controller.onWithdrawSendButtonClick,
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // primary: mainColor,
                  backgroundColor: secondaryColor,
                ),
                child: Text(
                  'submit'.tr,
                  style: TextStyle(
                    //fontFamily: FontFamily.inter,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            OperationListWidget(
              isDepositList: false,
              title: 'history_of_withdraws'.tr,
              marginTop: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
