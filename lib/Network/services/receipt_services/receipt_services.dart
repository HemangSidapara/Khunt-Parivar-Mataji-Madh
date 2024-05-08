import 'package:flutter/material.dart';
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
  }) async {
    final params = {
      ApiKeys.amount: amount,
      ApiKeys.name: personName,
      ApiKeys.phone: contactNumber,
      ApiKeys.address: address,
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
}
