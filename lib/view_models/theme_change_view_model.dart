import 'package:flutter/material.dart';

// style
import 'package:insta_clone/style.dart';

// repositories
import 'package:insta_clone/models/repositories/theme_change_repository.dart';

class ThemeChangeViewModel extends ChangeNotifier {
  final ThemeChangeRepository themeChangeRepository;
  ThemeChangeViewModel({this.themeChangeRepository});

  bool get isDark => ThemeChangeRepository.isDark;
  ThemeData get selectedTheme => isDark ? darkTheme : lightTheme;

  Future<void> setTheme() async {
    await themeChangeRepository.setTheme();
    notifyListeners();
  }
}
