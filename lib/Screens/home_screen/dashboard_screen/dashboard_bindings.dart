import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/dashboard_controller.dart';

class DashboardBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}
