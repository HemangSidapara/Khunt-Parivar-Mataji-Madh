import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/settings_screen/settings_controller.dart';

class SettingsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
  }
}
