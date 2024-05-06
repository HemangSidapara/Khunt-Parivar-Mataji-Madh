import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Screens/splash_screen/splash_controller.dart';

class SplashBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
