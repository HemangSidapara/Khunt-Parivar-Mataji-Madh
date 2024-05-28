import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_assets.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_colors.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_strings.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_utils.dart';
import 'package:khunt_parivar_mataji_madh/Network/services/utils_services/download_service.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/receipt_history_screen/receipt_history_controller.dart';
import 'package:khunt_parivar_mataji_madh/Widgets/custom_header_widget.dart';
import 'package:khunt_parivar_mataji_madh/Widgets/loading_widget.dart';
import 'package:khunt_parivar_mataji_madh/Widgets/textfield_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class ReceiptHistoryView extends GetView<ReceiptHistoryController> {
  const ReceiptHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;
    return GestureDetector(
      onTap: () => Utils.unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5.h),
            child: Column(
              children: [
                ///Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomHeaderWidget(
                        title: AppStrings.receiptHistory.tr,
                        titleIcon: AppAssets.challanIcon,
                        onBackPressed: () {
                          Get.back(closeOverlays: true);
                        },
                      ),
                      Obx(() {
                        return IconButton(
                          onPressed: controller.isRefreshing.value
                              ? () {}
                              : () async {
                                  await controller.getReceiptHistoryApiCall(isLoading: false);
                                },
                          style: IconButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                          ),
                          icon: Obx(() {
                            return TweenAnimationBuilder(
                              duration: Duration(seconds: controller.isRefreshing.value ? 45 : 1),
                              tween: Tween(begin: 0.0, end: controller.isRefreshing.value ? 45.0 : controller.ceilValueForRefresh.value),
                              onEnd: () {
                                controller.isRefreshing.value = false;
                              },
                              builder: (context, value, child) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  controller.ceilValueForRefresh(value.toDouble().ceilToDouble());
                                });
                                return Transform.rotate(
                                  angle: value * 2 * 3.141592653589793,
                                  child: Icon(
                                    Icons.refresh_rounded,
                                    color: AppColors.PRIMARY_COLOR,
                                    size: context.isPortrait ? 6.w : 6.h,
                                  ),
                                );
                              },
                            );
                          }),
                        );
                      }),
                    ],
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
                              CharityReceiptHistory(),
                              ExpenseReceiptHistory(),
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

  // ignore: non_constant_identifier_names
  Widget CharityReceiptHistory() {
    return Column(
      children: [
        SizedBox(height: 2.h),

        ///Searchbar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextFieldWidget(
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColors.SECONDARY_COLOR,
              size: 5.w,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 5.h, maxWidth: 8.w, minWidth: 8.w),
            suffixIcon: InkWell(
              onTap: () {
                Utils.unfocus();
                controller.searchCharityController.clear();
                controller.searchCharityName(controller.searchCharityController.text);
              },
              child: Icon(
                Icons.close_rounded,
                color: AppColors.SECONDARY_COLOR,
                size: 5.w,
              ),
            ),
            suffixIconConstraints: BoxConstraints(maxHeight: 5.h, maxWidth: 12.w, minWidth: 12.w),
            hintText: AppStrings.searchName.tr,
            controller: controller.searchCharityController,
            onChanged: controller.searchCharityName,
          ),
        ),
        SizedBox(height: 2.h),

        ///Data
        Expanded(
          child: Obx(
            () {
              if (controller.isGetInvoicesLoading.isTrue) {
                return const Center(
                  child: LoadingWidget(),
                );
              } else if (controller.searchedCharityList.isEmpty) {
                return Center(
                  child: Text(
                    AppStrings.noDataFound.tr,
                    style: TextStyle(
                      color: AppColors.PRIMARY_COLOR,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                  itemCount: controller.searchedCharityList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  itemBuilder: (context, index) {
                    final charityReceipt = controller.searchedCharityList[index];
                    return Card(
                      color: AppColors.TRANSPARENT,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ExpansionTile(
                        title: Row(
                          children: [
                            Text(
                              '${index + 1}. ',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.SECONDARY_COLOR,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Flexible(
                              child: Text(
                                controller.searchedCharityList[index].name ?? '',
                                style: TextStyle(
                                  color: AppColors.SECONDARY_COLOR,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        dense: true,
                        collapsedBackgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.7),
                        backgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.7),
                        iconColor: AppColors.SECONDARY_COLOR,
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        childrenPadding: EdgeInsets.only(bottom: 2.h),
                        trailing: IconButton(
                          onPressed: () async {
                            await showReceiptBottomSheet(
                              pdfUrl: charityReceipt.url ?? '',
                              fileName: "${charityReceipt.name}_${charityReceipt.datetime?.split(' ').firstOrNull?.replaceAll('-', '_')}.pdf",
                              contactNumber: charityReceipt.phone ?? '',
                            );
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.DARK_GREEN_COLOR,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(99),
                            ),
                            elevation: 4,
                            maximumSize: Size(8.w, 8.w),
                            minimumSize: Size(8.w, 8.w),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                          ),
                          icon: Icon(
                            Icons.download_rounded,
                            color: AppColors.PRIMARY_COLOR,
                            size: 5.w,
                          ),
                        ),
                        children: [
                          Divider(
                            color: AppColors.GREY_COLOR,
                            thickness: 1,
                          ),

                          ///Data & Amount
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ///Date
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ///Date
                                    Row(
                                      children: [
                                        Text(
                                          AppStrings.date.tr,
                                          style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          charityReceipt.datetime != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(charityReceipt.datetime!)) : '',
                                          style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),

                                    ///Amount
                                    Row(
                                      children: [
                                        Text(
                                          AppStrings.amount.tr,
                                          style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          "₹ ${charityReceipt.amount ?? ''}",
                                          style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),

                                ///Phone
                                Row(
                                  children: [
                                    Text(
                                      AppStrings.phoneNumber.tr,
                                      style: TextStyle(
                                        color: AppColors.SECONDARY_COLOR,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      charityReceipt.phone ?? '',
                                      style: TextStyle(
                                        color: AppColors.SECONDARY_COLOR,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),

                                ///Address
                                Flexible(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.address.tr,
                                        style: TextStyle(
                                          color: AppColors.SECONDARY_COLOR,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Flexible(
                                        child: Text(
                                          charityReceipt.address ?? '',
                                          style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 1.h),

                                ///Cheque number
                                if (charityReceipt.cash == "No")
                                  Row(
                                    children: [
                                      Text(
                                        AppStrings.chequeNumber.tr,
                                        style: TextStyle(
                                          color: AppColors.SECONDARY_COLOR,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        charityReceipt.chequeNumber ?? '',
                                        style: TextStyle(
                                          color: AppColors.SECONDARY_COLOR,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 2.h);
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget ExpenseReceiptHistory() {
    return Column(
      children: [
        SizedBox(height: 2.h),

        ///Searchbar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextFieldWidget(
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColors.SECONDARY_COLOR,
              size: 5.w,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 5.h, maxWidth: 8.w, minWidth: 8.w),
            suffixIcon: InkWell(
              onTap: () {
                Utils.unfocus();
                controller.searchCharityController.clear();
                controller.searchCharityName(controller.searchCharityController.text);
              },
              child: Icon(
                Icons.close_rounded,
                color: AppColors.SECONDARY_COLOR,
                size: 5.w,
              ),
            ),
            suffixIconConstraints: BoxConstraints(maxHeight: 5.h, maxWidth: 12.w, minWidth: 12.w),
            hintText: AppStrings.searchName.tr,
            controller: controller.searchCharityController,
            onChanged: controller.searchCharityName,
          ),
        ),
        SizedBox(height: 2.h),

        ///Data
        Expanded(
          child: Obx(
            () {
              if (controller.isGetInvoicesLoading.isTrue) {
                return const Center(
                  child: LoadingWidget(),
                );
              } else if (controller.searchedExpenseList.isEmpty) {
                return Center(
                  child: Text(
                    AppStrings.noDataFound.tr,
                    style: TextStyle(
                      color: AppColors.PRIMARY_COLOR,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                  itemCount: controller.searchedExpenseList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  itemBuilder: (context, index) {
                    final expenseReceipt = controller.searchedExpenseList[index];
                    return Card(
                      color: AppColors.TRANSPARENT,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ExpansionTile(
                        title: Row(
                          children: [
                            Text(
                              '${index + 1}. ',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.SECONDARY_COLOR,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Flexible(
                              child: Text(
                                controller.searchedExpenseList[index].name ?? '',
                                style: TextStyle(
                                  color: AppColors.SECONDARY_COLOR,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        dense: true,
                        collapsedBackgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.7),
                        backgroundColor: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.7),
                        iconColor: AppColors.SECONDARY_COLOR,
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        childrenPadding: EdgeInsets.only(bottom: 2.h),
                        trailing: IconButton(
                          onPressed: () async {
                            await showReceiptBottomSheet(
                              pdfUrl: expenseReceipt.url ?? '',
                              fileName: "${expenseReceipt.name}_${expenseReceipt.date?.replaceAll('/', '_')}.pdf",
                              contactNumber: expenseReceipt.phone ?? '',
                            );
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.DARK_GREEN_COLOR,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(99),
                            ),
                            elevation: 4,
                            maximumSize: Size(8.w, 8.w),
                            minimumSize: Size(8.w, 8.w),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                          ),
                          icon: Icon(
                            Icons.download_rounded,
                            color: AppColors.PRIMARY_COLOR,
                            size: 5.w,
                          ),
                        ),
                        children: [
                          Divider(
                            color: AppColors.GREY_COLOR,
                            thickness: 1,
                          ),

                          ///Data & Amount
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ///Note
                                Flexible(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.expenseNote.tr,
                                        style: TextStyle(
                                          color: AppColors.SECONDARY_COLOR,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Flexible(
                                        child: Text(
                                          expenseReceipt.note ?? '',
                                          style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 1.h),

                                ///Date
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ///Date
                                    Row(
                                      children: [
                                        Text(
                                          AppStrings.date.tr,
                                          style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          expenseReceipt.date ?? '',
                                          style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),

                                    ///Amount
                                    Row(
                                      children: [
                                        Text(
                                          AppStrings.amount.tr,
                                          style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          "₹ ${expenseReceipt.amount ?? ''}",
                                          style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),

                                ///Phone
                                Row(
                                  children: [
                                    Text(
                                      AppStrings.phoneNumber.tr,
                                      style: TextStyle(
                                        color: AppColors.SECONDARY_COLOR,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      expenseReceipt.phone ?? '',
                                      style: TextStyle(
                                        color: AppColors.SECONDARY_COLOR,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),

                                ///Cheque number
                                if (expenseReceipt.cash == "No")
                                  Row(
                                    children: [
                                      Text(
                                        AppStrings.chequeNumber.tr,
                                        style: TextStyle(
                                          color: AppColors.SECONDARY_COLOR,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        expenseReceipt.chequeNumber ?? '',
                                        style: TextStyle(
                                          color: AppColors.SECONDARY_COLOR,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 2.h);
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> showReceiptBottomSheet({
    required String pdfUrl,
    required String fileName,
    required String contactNumber,
  }) async {
    await showModalBottomSheet(
      context: Get.context!,
      constraints: BoxConstraints(maxWidth: 100.w, minWidth: 100.w, maxHeight: 95.h, minHeight: 0.h),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      useRootNavigator: true,
      clipBehavior: Clip.hardEdge,
      backgroundColor: AppColors.PRIMARY_COLOR,
      builder: (context) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ///Back & Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///Title
                    Text(
                      AppStrings.viewReceipt.tr,
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                      ),
                    ),

                    ///Back
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: IconButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: Icon(
                        Icons.close_rounded,
                        color: AppColors.SECONDARY_COLOR,
                        size: 6.w,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: AppColors.HINT_GREY_COLOR,
                  thickness: 1,
                ),
                SizedBox(height: 3.h),

                ///Viewer
                Flexible(
                  child: SfPdfViewerTheme(
                    data: SfPdfViewerThemeData(
                      backgroundColor: AppColors.PRIMARY_COLOR,
                      progressBarColor: AppColors.TERTIARY_COLOR,
                    ),
                    child: SfPdfViewer.network(
                      pdfUrl,
                      onDocumentLoadFailed: (details) {
                        debugPrint("SfPdfViewer error :: ${details.description}");
                        Utils.handleMessage(message: details.description, isError: true);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 2.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ///Download
                    ElevatedButton(
                      onPressed: () async {
                        await Get.put(DownloaderService()).fileDownloadService(
                          url: pdfUrl,
                          fileName: fileName,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.DARK_GREEN_COLOR,
                        fixedSize: Size(35.w, 5.h),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Icon(
                        Icons.download_rounded,
                        color: AppColors.PRIMARY_COLOR,
                        size: 6.w,
                      ),
                    ),

                    ///Share
                    ElevatedButton(
                      onPressed: () async {
                        final isExist = await WhatsappShare.isInstalled();
                        if (isExist == true) {
                          final cacheFile = await Get.put(DownloaderService()).fileDownloadService(
                            url: pdfUrl,
                            fileName: fileName,
                            showLoader: false,
                          );
                          if (cacheFile != null) {
                            await WhatsappShare.shareFile(
                              phone: '91$contactNumber',
                              filePath: [cacheFile.path],
                            );
                          }
                        } else {
                          Utils.handleMessage(message: AppStrings.whatsappNotInstalled.tr, isWarning: true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.LIGHT_BLUE_COLOR,
                        fixedSize: Size(35.w, 5.h),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Icon(
                        FontAwesomeIcons.whatsapp,
                        color: AppColors.PRIMARY_COLOR,
                        size: 6.w,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
