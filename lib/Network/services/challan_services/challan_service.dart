import 'package:flutter/material.dart';
import 'package:khunt_parivar_mataji_madh/Constants/api_urls.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_utils.dart';
import 'package:khunt_parivar_mataji_madh/Network/api_base_helper.dart';
import 'package:khunt_parivar_mataji_madh/Network/response_model.dart';

class ChallanService {
  static Future<ResponseModel> getInvoicesService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getInvoicesApi,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) {
        if (res.isSuccess) {
          debugPrint("getInvoicesApi success :: ${res.message}");
        } else {
          debugPrint("getInvoicesApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );
    return response;
  }
}
