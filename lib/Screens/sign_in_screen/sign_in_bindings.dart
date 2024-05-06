import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Screens/sign_in_screen/sign_in_controller.dart';

class SignInBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
  }
}
