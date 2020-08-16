import 'package:flutter/material.dart';
import 'package:insta_clone/style.dart';
import 'package:provider/provider.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// view models
import 'package:insta_clone/view_models/profile_view_model.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// screens
import 'package:insta_clone/view/profile/screens/edit_profile_screen.dart';

class ProfileBio extends StatelessWidget {
  final ProfileMode profileMode;
  ProfileBio({@required this.profileMode});

  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    final profileUser = profileViewModel.profileUser;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(profileUser.inAppUserName),
        SizedBox(height: 4.0),
        Text(profileUser.bio, style: profileBioTextStyle),
        SizedBox(height: 16.0),
        SizedBox(
          width: double.infinity,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: profileMode == ProfileMode.MYSELF
                ? Text(S.of(context).editProfile)
                : Text(S.of(context).follow), // TODO: フォローしているかの判定
            onPressed: () => _openEditProfileScreen(context),
          ),
        )
      ],
    );
  }

  _openEditProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditProfileScreen()),
    );
  }
}
