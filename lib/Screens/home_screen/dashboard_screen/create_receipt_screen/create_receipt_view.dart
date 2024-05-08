import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_assets.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_colors.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_strings.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_utils.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/create_receipt_screen/charity_receipt_view.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/create_receipt_screen/create_receipt_controller.dart';
import 'package:khunt_parivar_mataji_madh/Widgets/custom_header_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateReceiptView extends GetView<CreateReceiptController> {
  const CreateReceiptView({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;
    return GestureDetector(
      onTap: () => Utils.unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomSheet: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h).copyWith(top: 0),
            child: ElevatedButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                if (controller.tabController.index == 0) {
                } else {}
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.PRIMARY_COLOR,
                fixedSize: Size(90.w, 6.h),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                AppStrings.save.tr,
                style: TextStyle(
                  color: AppColors.SECONDARY_COLOR,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5.h),
            child: Column(
              children: [
                ///Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: CustomHeaderWidget(
                    title: AppStrings.createReceipt.tr,
                    titleIcon: AppAssets.createReceiptImage,
                    onBackPressed: () {
                      Get.back(closeOverlays: true);
                    },
                  ),
                ),
                SizedBox(height: 2.h),

                ///Tabs
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: keyboardPadding),
                    child: Column(
                      children: [
                        TabBar(
                          controller: controller.tabController,
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          isScrollable: false,
                          tabAlignment: TabAlignment.fill,
                          labelColor: AppColors.PRIMARY_COLOR,
                          labelPadding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 1.h,
                          ),
                          indicatorPadding: EdgeInsets.zero,
                          indicatorColor: AppColors.TERTIARY_COLOR,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 2.5,
                          indicator: UnderlineTabIndicator(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.TERTIARY_COLOR,
                              width: 2.5,
                            ),
                          ),
                          onTap: (value) {
                            Utils.unfocus();
                            controller.tabController.animateTo(value);
                          },
                          dividerColor: AppColors.TRANSPARENT,
                          tabs: [
                            ///Charity
                            Text(
                              AppStrings.charity.tr,
                              style: TextStyle(
                                color: AppColors.TERTIARY_COLOR,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            ///Expenses
                            Text(
                              AppStrings.expense.tr,
                              style: TextStyle(
                                color: AppColors.TERTIARY_COLOR,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: TabBarView(
                            controller: controller.tabController,
                            children: [
                              Form(
                                key: controller.charityFormKey,
                                child: const CharityReceiptView(),
                              ),
                              const CharityReceiptView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
