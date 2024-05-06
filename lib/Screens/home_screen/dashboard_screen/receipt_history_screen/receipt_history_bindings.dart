import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/receipt_history_screen/receipt_history_controller.dart';

class ReceiptHistoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ReceiptHistoryController());
  }
}
