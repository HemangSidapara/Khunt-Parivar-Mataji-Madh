import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_assets.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_colors.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_strings.dart';
import 'package:khunt_parivar_mataji_madh/Routes/app_pages.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/dashboard_controller.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/hand_shaken_animation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      child: Column(
        children: [
          ///Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.hello.tr,
                      style: TextStyle(
                        color: AppColors.PRIMARY_COLOR.withOpacity(0.8),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const HandShakenAnimation(),
                  ],
                ),
              ),
              SizedBox(width: 2.w),
            ],
          ),
          SizedBox(height: 2.h),

          ///Create Receipt
          ElevatedButton(
            onPressed: () async {
              Get.toNamed(Routes.createReceiptScreen);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.LIGHT_SECONDARY_COLOR,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 65.w,
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.createReceiptImage,
                          width: 18.w,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          AppStrings.createReceipt.tr,
                          style: TextStyle(
                            color: AppColors.SECONDARY_COLOR,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    AppAssets.frontIcon,
                    width: 9.w,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),

          ///Receipt History
          ElevatedButton(
            onPressed: () async {
              Get.toNamed(Routes.receiptHistoryScreen);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.LIGHT_SECONDARY_COLOR,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 65.w,
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.challanIcon,
                          width: 18.w,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          AppStrings.receiptHistory.tr,
                          style: TextStyle(
                            color: AppColors.SECONDARY_COLOR,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    AppAssets.frontIcon,
                    width: 9.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
