import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
