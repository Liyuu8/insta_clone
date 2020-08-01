import 'package:flutter/material.dart';
import 'package:insta_clone/style.dart';

// screens
import 'package:insta_clone/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      // TODO:
      home: HomeScreen(),
    );
  }
}
