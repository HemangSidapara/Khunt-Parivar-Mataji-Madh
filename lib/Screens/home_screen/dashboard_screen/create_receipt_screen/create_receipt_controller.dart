import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_strings.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_validators.dart';
import 'package:khunt_parivar_mataji_madh/Network/models/receipt_models/receipt_model.dart';
import 'package:khunt_parivar_mataji_madh/Network/services/receipt_services/receipt_services.dart';

class CreateReceiptController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  GlobalKey<FormState> charityFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> expenseFormKey = GlobalKey<FormState>();

  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  ///validate amount
  String? validateAmount(String? value) {
    if (value?.isEmpty == true || value == null) {
      return AppStrings.pleaseEnterAmount;
    } else if (!AppValidators.phoneNumberValidator.hasMatch(value)) {
      return AppStrings.amountMustBeNumericOnly;
    }

    return null;
  }

  ///validate name
  String? validateName(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterPersonName.tr;
    }
    return null;
  }

  ///validate phone number
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isNotEmpty || !AppValidators.phoneNumberValidator.hasMatch(value)) {
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

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  Future<void> generateCharityReceiptApiCall() async {
    final isValidate = charityFormKey.currentState?.validate();

    if (isValidate == true) {}
  }

  Future<void> generateExpenseReceiptApiCall() async {
    final isValidate = expenseFormKey.currentState?.validate();

    if (isValidate == true) {
      final response = await ReceiptServices.generateCharityReceiptService(
        amount: amountController.text.trim(),
        personName: nameController.text.trim(),
        contactNumber: phoneNumberController.text.trim(),
        address: addressController.text.trim(),
      );

      if (response.isSuccess) {
        ReceiptModel receiptModel = ReceiptModel.fromJson(response.response?.data);
      }
    }
  }
}
