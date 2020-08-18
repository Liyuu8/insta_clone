import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeAgo;

// generated
import 'package:insta_clone/generated/l10n.dart';

// screens
import 'package:insta_clone/view/common/screens/home_screen.dart';
import 'package:insta_clone/view/login/screens/login_screen.dart';

// di
import 'package:insta_clone/di/providers.dart';

// view models
import 'package:insta_clone/view_models/login_view_model.dart';
import 'package:insta_clone/view_models/theme_change_view_model.dart';

// repositories
import 'package:insta_clone/models/repositories/theme_change_repository.dart';

void main() {
  // 非同期処理を行うために必要らしい
  WidgetsFlutterBinding.ensureInitialized();

  // ViewModel が使えないため、Repository を直接アクセス
  final themeChangeRepository = ThemeChangeRepository();
  themeChangeRepository.getTheme();

  timeAgo.setLocaleMessages('ja', timeAgo.JaMessages());
  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.watch<LoginViewModel>();
    final themeChangeViewModel = context.watch<ThemeChangeViewModel>();

    return MaterialApp(
      title: 'InstaClone',
      debugShowCheckedModeBanner: false,
      theme: themeChangeViewModel.selectedTheme,
      localizationsDelegates: [
        // 多言語対応
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales, // 多言語対応
      home: FutureBuilder(
        future: loginViewModel.isSignIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) =>
            snapshot.hasData && snapshot.data ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}
