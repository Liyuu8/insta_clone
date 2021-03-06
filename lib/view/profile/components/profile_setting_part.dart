import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// view models
import 'package:insta_clone/view_models/profile_view_model.dart';
import 'package:insta_clone/view_models/theme_change_view_model.dart';

// screens
import 'package:insta_clone/view/login/screens/login_screen.dart';

class ProfileSettingPart extends StatelessWidget {
  final ProfileMode profileMode;
  ProfileSettingPart({@required this.profileMode});

  @override
  Widget build(BuildContext context) {
    final themeChangeViewModel = context.watch<ThemeChangeViewModel>();
    final isDarkOn = themeChangeViewModel.isDark;

    return PopupMenuButton(
      icon: Icon(Icons.settings),
      onSelected: (value) => _onPopupMenuSelected(context, value),
      itemBuilder: (context) => profileMode == ProfileMode.MYSELF
          ? [
              PopupMenuItem(
                value: ProfileSettingMenu.THEME_CHANGE,
                child: isDarkOn
                    ? Text(S.of(context).changeToLightTheme)
                    : Text(S.of(context).changeToDarkTheme),
              ),
              PopupMenuItem(
                value: ProfileSettingMenu.SIGN_OUT,
                child: Text(S.of(context).signOut),
              ),
            ]
          : [
              PopupMenuItem(
                value: ProfileSettingMenu.SIGN_OUT,
                child: Text(S.of(context).signOut),
              ),
            ],
    );
  }

  _onPopupMenuSelected(
    BuildContext context,
    ProfileSettingMenu selectedMenu,
  ) {
    switch (selectedMenu) {
      case ProfileSettingMenu.THEME_CHANGE:
        final themeChangeViewModel = context.read<ThemeChangeViewModel>();
        themeChangeViewModel.setTheme();
        break;
      case ProfileSettingMenu.SIGN_OUT:
        _signOut(context);
        break;
    }
  }

  _signOut(BuildContext context) async {
    final profileViewModel = context.read<ProfileViewModel>();
    profileViewModel.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }
}
