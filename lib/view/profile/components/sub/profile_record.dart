import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// style
import 'package:insta_clone/style.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// view models
import 'package:insta_clone/view_models/profile_view_model.dart';

// screens
import 'package:insta_clone/view/who_cares_me/screens/who_cares_me_screen.dart';

class ProfileRecord extends StatelessWidget {
  final String title;
  final int score;
  final WhoCaresMeMode whoCaresMeMode;
  ProfileRecord({
    @required this.title,
    @required this.score,
    this.whoCaresMeMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: whoCaresMeMode == null ? null : () => _checkFollowUsers(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(title, style: profileRecordTitleTextStyle),
          Text(score.toString(), style: profileRecordScoreTextStyle),
        ],
      ),
    );
  }

  _checkFollowUsers(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WhoCaresMeScreen(
          whoCaresMeMode: whoCaresMeMode,
          id: profileViewModel.profileUser.userId,
        ),
      ),
    );
  }
}
