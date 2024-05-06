import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/create_receipt_screen/create_receipt_bindings.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/create_receipt_screen/create_receipt_view.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/dashboard_bindings.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/receipt_history_screen/receipt_history_bindings.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/dashboard_screen/receipt_history_screen/receipt_history_view.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/home_bindings.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/home_view.dart';
import 'package:khunt_parivar_mataji_madh/Screens/home_screen/settings_screen/settings_bindings.dart';
import 'package:khunt_parivar_mataji_madh/Screens/sign_in_screen/sign_in_bindings.dart';
import 'package:khunt_parivar_mataji_madh/Screens/sign_in_screen/sign_in_view.dart';
import 'package:khunt_parivar_mataji_madh/Screens/splash_screen/splash_bindings.dart';
import 'package:khunt_parivar_mataji_madh/Screens/splash_screen/splash_view.dart';

part 'app_routes.dart';

Duration transitionDuration = const Duration(milliseconds: 400);

class AppPages {
  static final pages = [
    ///Splash Screen
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashView(),
      binding: SplashBindings(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),

    ///SignIn Screen
    GetPage(
      name: Routes.signInScreen,
      page: () => const SignInView(),
      binding: SignInBindings(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),

    ///Home Screen
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeView(),
      binding: HomeBindings(),
      bindings: [
        DashboardBindings(),
        SettingsBindings(),
      ],
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),

    ///Create Receipt Screen
    GetPage(
      name: Routes.createReceiptScreen,
      page: () => const CreateReceiptView(),
      binding: CreateReceiptBindings(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),

    ///Receipt History Screen
    GetPage(
      name: Routes.receiptHistoryScreen,
      page: () => const ReceiptHistoryView(),
      binding: ReceiptHistoryBindings(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: transitionDuration,
    ),
  ];
}
