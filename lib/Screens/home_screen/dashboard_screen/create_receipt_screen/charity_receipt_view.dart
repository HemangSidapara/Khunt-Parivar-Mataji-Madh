import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_colors.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_strings.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/create_receipt_screen/create_receipt_controller.dart';
import 'package:khunt_parivar_mataji_madh/Widgets/textfield_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CharityReceiptView extends StatefulWidget {
  const CharityReceiptView({super.key});

  @override
  State<CharityReceiptView> createState() => _CharityReceiptViewState();
}

class _CharityReceiptViewState extends State<CharityReceiptView> {
  CreateReceiptController controller = Get.put(CreateReceiptController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: 4.h),

            ///Amount
            TextFieldWidget(
              controller: controller.amountController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: controller.validateAmount,
              hintText: "₹ 100",
              maxLength: 10,
            ),
            SizedBox(height: 3.h),

            ///DefaultAmount
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///₹ 100
                  DefaultAmountWidget(
                    onPressed: () {
                      controller.amountController.text = "100";
                    },
                    text: "₹ 100",
                  ),

                  ///₹ 500
                  DefaultAmountWidget(
                    onPressed: () {
                      controller.amountController.text = "500";
                    },
                    text: "₹ 500",
                  ),

                  ///₹ 1000
                  DefaultAmountWidget(
                    onPressed: () {
                      controller.amountController.text = "1000";
                    },
                    text: "₹ 1000",
                  ),

                  ///₹ 2000
                  DefaultAmountWidget(
                    onPressed: () {
                      controller.amountController.text = "2000";
                    },
                    text: "₹ 2000",
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            ///Name
            TextFieldWidget(
              controller: controller.nameController,
              textInputAction: TextInputAction.next,
              title: AppStrings.personName.tr,
              hintText: AppStrings.enterPersonName.tr,
              validator: (value) {
                return controller.validateName(value!);
              },
              maxLength: 30,
            ),
            SizedBox(height: 2.h),

            ///Phone Number
            TextFieldWidget(
              controller: controller.phoneNumberController,
              textInputAction: TextInputAction.next,
              title: AppStrings.phoneNumber.tr,
              hintText: AppStrings.enterPhoneNumber.tr,
              keyboardType: TextInputType.number,
              validator: controller.validatePhoneNumber,
              maxLength: 30,
            ),
            SizedBox(height: 2.h),

            ///Address
            TextFieldWidget(
              controller: controller.addressController,
              textInputAction: TextInputAction.next,
              title: AppStrings.address.tr,
              hintText: AppStrings.enterAddress.tr,
              validator: controller.validateAddress,
              maxLength: 50,
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget DefaultAmountWidget({required void Function()? onPressed, required String text}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: 4,
        backgroundColor: AppColors.PRIMARY_COLOR,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.SECONDARY_COLOR,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
