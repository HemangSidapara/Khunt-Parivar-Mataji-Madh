import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_colors.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_strings.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_utils.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_validators.dart';
import 'package:khunt_parivar_mataji_madh/Network/models/receipt_models/receipt_model.dart';
import 'package:khunt_parivar_mataji_madh/Network/services/receipt_services/receipt_services.dart';
import 'package:khunt_parivar_mataji_madh/Network/services/utils_services/download_service.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class CreateReceiptController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  GlobalKey<FormState> charityFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> expenseFormKey = GlobalKey<FormState>();

  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController chequeNumberController = TextEditingController();

  TextEditingController expenseAmountController = TextEditingController();
  TextEditingController expenseNameController = TextEditingController();
  TextEditingController expenseNoteController = TextEditingController();
  TextEditingController expensePhoneNumberController = TextEditingController();
  TextEditingController expenseChequeNumberController = TextEditingController();
  TextEditingController expenseDateController = TextEditingController();

  RxBool isChequeSelected = false.obs;
  RxBool isExpenseChequeSelected = false.obs;

  ///validate amount
  String? validateAmount(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseEnterAmount;
    } else if (!AppValidators.phoneNumberValidator.hasMatch(value)) {
      return AppStrings.amountMustBeNumericOnly;
    }

    return null;
  }

  ///validate name
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterPersonName.tr;
    }
    return null;
  }

  ///validate phone number
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterValidPhoneNumber.tr;
    }
    return null;
  }

  ///validate address
  String? validateAddress(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseEnterAddress.tr;
    }
    return null;
  }

  ///validate cheque number
  String? validateChequeNumber(String? value) {
    if ((isChequeSelected.isTrue || isExpenseChequeSelected.isTrue) && (value == null || value.isEmpty == true)) {
      return AppStrings.pleaseEnterChequeNumber.tr;
    }
    return null;
  }

  ///validate expense name
  String? validateExpenseName(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseEnterExpenseName.tr;
    }
    return null;
  }

  ///validate expense note
  String? validateExpenseNote(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseEnterExpenseNote.tr;
    }
    return null;
  }

  ///validate expense note
  String? validateExpenseDate(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseSelectExpenseDate.tr;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    expenseDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  Future<void> generateCharityReceiptApiCall() async {
    final isValidate = charityFormKey.currentState?.validate();

    if (isValidate == true) {
      final response = await ReceiptServices.generateCharityReceiptService(
        amount: amountController.text.trim(),
        personName: nameController.text.trim(),
        contactNumber: phoneNumberController.text.trim(),
        address: addressController.text.trim(),
        chequeNumber: isChequeSelected.isTrue ? chequeNumberController.text.trim() : null,
      );

      if (response.isSuccess) {
        ReceiptModel receiptModel = ReceiptModel.fromJson(response.response?.data);
        await showReceiptBottomSheet(
          pdfUrl: receiptModel.path ?? '',
          fileName: "${nameController.text.trim()}_${DateTime.now().toIso8601String().split('T').firstOrNull?.replaceAll('-', '_')}.pdf",
          contactNumber: phoneNumberController.text.trim(),
        );
      }
    }
  }

  Future<void> generateExpenseReceiptApiCall() async {
    final isValidate = expenseFormKey.currentState?.validate();

    if (isValidate == true) {
      final response = await ReceiptServices.generateExpenseReceiptService(
        amount: expenseAmountController.text.trim(),
        expenseName: expenseNameController.text.trim(),
        expenseNote: expenseNoteController.text.trim(),
        phone: expensePhoneNumberController.text.trim(),
        chequeNumber: isChequeSelected.isTrue ? chequeNumberController.text.trim() : null,
        date: expenseDateController.text.trim(),
      );

      if (response.isSuccess) {
        ReceiptModel receiptModel = ReceiptModel.fromJson(response.response?.data);
        await showReceiptBottomSheet(
          pdfUrl: receiptModel.path ?? '',
          fileName: "${expenseNameController.text.trim()}_${expenseDateController.text.trim().replaceAll('/', '_')}.pdf",
          contactNumber: expensePhoneNumberController.text.trim(),
        );
      }
    }
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
