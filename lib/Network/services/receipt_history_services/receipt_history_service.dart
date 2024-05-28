import 'package:flutter/material.dart';
import 'package:khunt_parivar_mataji_madh/Constants/api_urls.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_utils.dart';
import 'package:khunt_parivar_mataji_madh/Network/api_base_helper.dart';
import 'package:khunt_parivar_mataji_madh/Network/response_model.dart';

class ReceiptHistoryService {
  /// Get receipt history
  static Future<ResponseModel> getReceiptHistoryService() async {
    final response = ApiBaseHelper.getHTTP(
      ApiUrls.getBillingApi,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      showProgress: false,
      onSuccess: (res) {
        if (res.isSuccess) {
          debugPrint("getBilling success ::: ${res.message}");
        } else {
          debugPrint("getBilling error ::: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }
}
