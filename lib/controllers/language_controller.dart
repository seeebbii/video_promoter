import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  SharedPreferences prefs;

  void changeLanguage(var param1, var param2) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('param1', param1);
    prefs.setString('param2', param2);
    var locale = Locale(param1, param2);
    Get.updateLocale(locale);
  }
}
