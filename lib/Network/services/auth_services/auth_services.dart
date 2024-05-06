import 'package:flutter/material.dart';
import 'package:khunt_parivar_mataji_madh/Constants/api_keys.dart';
import 'package:khunt_parivar_mataji_madh/Constants/api_urls.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_constance.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_utils.dart';
import 'package:khunt_parivar_mataji_madh/Constants/get_storage.dart';
import 'package:khunt_parivar_mataji_madh/Network/api_base_helper.dart';
import 'package:khunt_parivar_mataji_madh/Network/models/auth_models/get_latest_version_model.dart';
import 'package:khunt_parivar_mataji_madh/Network/models/auth_models/login_model.dart';
import 'package:khunt_parivar_mataji_madh/Network/response_model.dart';

class AuthServices {
  static Future<ResponseModel> getLatestVersionService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.inAppUpdateApi,
      showProgress: false,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          GetLatestVersionModel latestVersionModel = GetLatestVersionModel.fromJson(res.response?.data);
          debugPrint("inAppUpdateApi success :: ${latestVersionModel.msg}");
        } else {
          debugPrint("inAppUpdateApi error :: ${res.message}");
        }
      },
    );

    return response;
  }

  static Future<ResponseModel> loginService({
    required String username,
    required String password,
  }) async {
    final params = {
      ApiKeys.username: username,
      ApiKeys.password: password,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.loginApi,
      params: params,
      onError: (dioExceptions) {
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          LoginModel loginModel = LoginModel.fromJson(res.response?.data);
          await setData(AppConstance.userId, loginModel.userId);
          debugPrint("loginApi success :: ${loginModel.msg}");
          Utils.handleMessage(message: loginModel.msg);
        } else {
          debugPrint("loginApi error :: ${res.message}");
          Utils.handleMessage(message: res.message, isError: true);
        }
      },
    );

    return response;
  }
}
