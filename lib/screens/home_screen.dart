import 'package:flutter/material.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO:
      body: Center(
        child: Text(S.of(context).appTitle),
      ),
    );
  }
}
