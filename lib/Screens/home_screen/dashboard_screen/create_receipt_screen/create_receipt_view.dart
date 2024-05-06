import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_assets.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_strings.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_utils.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/create_receipt_screen/create_receipt_controller.dart';
import 'package:khunt_parivar_mataji_madh/Widgets/custom_header_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateReceiptView extends GetView<CreateReceiptController> {
  const CreateReceiptView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.5.h),
            child: Column(
              children: [
                ///Header
                CustomHeaderWidget(
                  title: AppStrings.createReceipt.tr,
                  titleIcon: AppAssets.createReceiptImage,
                  onBackPressed: () {
                    Get.back(closeOverlays: true);
                  },
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}