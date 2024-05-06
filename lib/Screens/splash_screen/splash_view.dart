import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_assets.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_colors.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_constance.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_strings.dart';
import 'package:khunt_parivar_mataji_madh/Screens/splash_screen/splash_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.SECONDARY_COLOR,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    AppAssets.splashImage,
                    height: 50.h,
                  ),
                ),
                Text(
                  AppStrings.appName.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            return Text(
              AppConstance.appVersion.replaceAll('1.0.0', controller.currentVersion.value),
              style: TextStyle(
                color: AppColors.PRIMARY_COLOR.withOpacity(0.55),
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            );
          }),
          Text(
            AppStrings.poweredByMindwaveInfoway,
            style: TextStyle(
              color: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.55),
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
