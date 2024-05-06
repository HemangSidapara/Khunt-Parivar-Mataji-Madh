import 'package:get/get.dart';
import 'package:khunt_parivar_mataji_madh/Localization/en_in.dart';
import 'package:khunt_parivar_mataji_madh/Localization/gu_in.dart';
import 'package:khunt_parivar_mataji_madh/Localization/hi_in.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en_IN': enIN,
      'hi_IN': hiIN,
      'gu_IN': guIN,
    };
  }
}
