import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Constants/api_keys.dart';
import 'package:khunt_parivar_mataji_madh/Constants/api_urls.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_utils.dart';
import 'package:khunt_parivar_mataji_madh/Network/api_base_helper.dart';
import 'package:khunt_parivar_mataji_madh/Network/response_model.dart';

class ReceiptServices {
  /// Generate Charity Receipt
  static Future<ResponseModel> generateCharityReceiptService({
    required String amount,
    required String personName,
    required String contactNumber,
    required String address,
    required String? chequeNumber,
  }) async {
    final params = {
      ApiKeys.amount: amount,
      ApiKeys.name: personName,
      ApiKeys.phone: contactNumber,
      ApiKeys.address: address,
      ApiKeys.cash: (chequeNumber == null).toString().capitalize,
      ApiKeys.chequeNumber: chequeNumber,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.generateReceiptApi,
      params: params,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          debugPrint("generateReceiptApi success :: ${res.message}");
        } else {
          debugPrint("generateReceiptApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }

  /// Generate Expense Receipt
  static Future<ResponseModel> generateExpenseReceiptService({
    required String amount,
    required String expenseName,
    required String expenseNote,
    required String phone,
    required String? chequeNumber,
    required String date,
  }) async {
    final params = {
      ApiKeys.amount: amount,
      ApiKeys.name: expenseName,
      ApiKeys.note: expenseNote,
      ApiKeys.phone: phone,
      ApiKeys.cash: (chequeNumber == null).toString().capitalize,
      ApiKeys.chequeNumber: chequeNumber,
      ApiKeys.date: date,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.generateExpenseApi,
      params: params,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          debugPrint("generateExpenseApi success :: ${res.message}");
        } else {
          debugPrint("generateExpenseApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }
}
