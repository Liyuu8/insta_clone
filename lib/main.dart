import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// style
import 'package:insta_clone/style.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// screens
import 'package:insta_clone/view/common/screens/home_screen.dart';
import 'package:insta_clone/view/login/screens/login_screen.dart';

// di
import 'package:insta_clone/di/providers.dart';

// view models
import 'package:insta_clone/view_models/login_view_model.dart';

void main() => runApp(
      MultiProvider(
        providers: globalProviders,
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.watch<LoginViewModel>();

    return MaterialApp(
      title: 'InstaClone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        buttonColor: Colors.white30,
        primaryIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        fontFamily: RegularFont,
      ),

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
