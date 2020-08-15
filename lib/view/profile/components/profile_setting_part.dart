import 'package:flutter/material.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

class ProfileSettingPart extends StatelessWidget {
  final ProfileMode profileMode;
  ProfileSettingPart({@required this.profileMode});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.settings),
      onSelected: (value) => _onPopupMenuSelected(context, value),
      itemBuilder: (context) => profileMode == ProfileMode.MYSELF
          ? [
              PopupMenuItem(
                value: ProfileSettingMenu.THEME_CHANGE,
                child: Text(S.of(context).changeToLightTheme),
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

  // TODO:
  _onPopupMenuSelected(BuildContext context, value) {}
}
