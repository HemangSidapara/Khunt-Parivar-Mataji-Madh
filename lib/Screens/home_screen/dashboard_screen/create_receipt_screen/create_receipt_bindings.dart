import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/create_receipt_screen/create_receipt_controller.dart';

class CreateReceiptBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(CreateReceiptController());
  }
}
