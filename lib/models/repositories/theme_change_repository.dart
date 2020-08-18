import 'package:shared_preferences/shared_preferences.dart';

const PREF_KEY = 'isDark';

class ThemeChangeRepository {
  static bool isDark = true;

  Future<void> setTheme() async {
    isDark = !isDark;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(PREF_KEY, isDark);
  }

  Future<void> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool(PREF_KEY) ?? true;
  }
}
