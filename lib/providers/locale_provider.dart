import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/strings.dart';

class LocaleProvider with ChangeNotifier {
  static const _prefsKey = 'app_locale';

  AppLocale _locale = AppLocale.en;

  AppLocale get locale => _locale;

  Locale get materialLocale => Locale(_locale == AppLocale.tr ? 'tr' : 'en');

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefsKey);
    _locale = saved == 'tr' ? AppLocale.tr : AppLocale.en;
    AppStrings.setLocale(_locale);
    notifyListeners();
  }

  Future<void> setLocale(AppLocale locale) async {
    _locale = locale;
    AppStrings.setLocale(locale);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, locale == AppLocale.tr ? 'tr' : 'en');
  }
}
