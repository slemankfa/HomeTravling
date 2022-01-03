import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';

class LocaliztionHelper {
  static final LocaliztionHelper _singleton = LocaliztionHelper._internal();

  factory LocaliztionHelper() {
    return _singleton;
  }

  LocaliztionHelper._internal();

  String checkLanguage(BuildContext context) {
    if (context.deviceLocale.languageCode.toString() == "ar") {
      return "ar";
    } else {
      return "en";
    }
  }
}
