import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_colors.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_constance.dart';
import 'package:khunt_parivar_mataji_madh/Constants/app_strings.dart';
import 'package:khunt_parivar_mataji_madh/Constants/get_storage.dart';
import 'package:khunt_parivar_mataji_madh/Localization/localization.dart';
import 'package:khunt_parivar_mataji_madh/Routes/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([]);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          translations: Localization(),
          locale: getString(AppConstance.languageCode) != null && getString(AppConstance.languageCode) != '' && getString(AppConstance.languageCountryCode) != null && getString(AppConstance.languageCountryCode) != '' ? Locale(getString(AppConstance.languageCode) ?? Get.deviceLocale?.languageCode ?? 'en', getString(AppConstance.languageCountryCode)) : Get.deviceLocale,
          fallbackLocale: const Locale('en', 'IN'),
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.SECONDARY_COLOR,
            primaryColor: AppColors.PRIMARY_COLOR,
            textTheme: GoogleFonts.nunitoSansTextTheme(),
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: AppColors.SECONDARY_COLOR,
              backgroundColor: AppColors.PRIMARY_COLOR,
              headerForegroundColor: AppColors.PRIMARY_COLOR,
            ),
            useMaterial3: true,
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: AppColors.SECONDARY_COLOR,
            ),
          ),
          initialRoute: Routes.splashScreen,
          defaultTransition: Transition.downToUp,
          getPages: AppPages.pages,
        );
      },
    );
  }
}
