import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_strings.dart';
import 'package:khunt_parivar_mataji_madh/Network/services/auth_services/auth_services.dart';
import 'package:khunt_parivar_mataji_madh/Routes/app_pages.dart';

class SignInController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;

  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  RxBool isSignInLoading = false.obs;

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseEnterUserName.tr;
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty == true) {
      return AppStrings.pleaseEnterPassword.tr;
    }
    return null;
  }

  Future<void> checkSignIn() async {
    try {
      isSignInLoading(true);
      final isValid = signInFormKey.currentState?.validate();

      if (isValid == true) {
        final response = await AuthServices.loginService(
          username: usernameController.text,
          password: passwordController.text,
        );

        if (response.isSuccess) {
          Get.offAllNamed(Routes.homeScreen);
        }
      }
    } finally {
      isSignInLoading(false);
    }
  }
}
