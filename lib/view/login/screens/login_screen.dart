import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// style
import 'package:insta_clone/style.dart';

// components
import 'package:insta_clone/view/common/components/button_with_icon.dart';

// view models
import 'package:insta_clone/view_models/login_view_model.dart';

// screens
import 'package:insta_clone/view/common/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LoginViewModel>(
          builder: (context, model, child) => model.isLoading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      S.of(context).appTitle,
                      style: loginTitleTextStyle,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    ButtonWithIcon(
                      onPressed: () => login(context),
                      iconData: FontAwesomeIcons.signInAlt,
                      label: S.of(context).signIn,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  login(BuildContext context) async {
    final loginViewModel = context.read<LoginViewModel>();
    await loginViewModel.signIn();
    if (!loginViewModel.isSuccessful) {
      Fluttertoast.showToast(msg: S.of(context).signInFailed);
      return;
    }
    _openHomeScreen(context);
  }

  void _openHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }
}
