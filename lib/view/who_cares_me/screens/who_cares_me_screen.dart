import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// generate
import 'package:insta_clone/generated/l10n.dart';

// data models
import 'package:insta_clone/data_models/user.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// components
import 'package:insta_clone/view/common/components/user_card.dart';

// view models
import 'package:insta_clone/view_models/who_cares_me_view_model.dart';

// screens
import 'package:insta_clone/view/profile/screens/profile_screen.dart';

class WhoCaresMeScreen extends StatelessWidget {
  final WhoCaresMeMode whoCaresMeMode;
  final String id;
  WhoCaresMeScreen({
    @required this.whoCaresMeMode,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final whoCaresMeViewModel =
        Provider.of<WhoCaresMeViewModel>(context, listen: false);
    Future(() => whoCaresMeViewModel.getCaresMeUsers(whoCaresMeMode, id));

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitleText(context, whoCaresMeMode)),
      ),
      body: Consumer<WhoCaresMeViewModel>(
        builder: (context, model, child) => model.caresMeUsers.isNotEmpty
            ? ListView.builder(
                itemCount: model.caresMeUsers.length,
                itemBuilder: (context, int index) {
                  final caresMeUser = model.caresMeUsers[index];
                  return UserCard(
                    photoUrl: caresMeUser.photoUrl,
                    title: caresMeUser.inAppUserName,
                    subTitle: caresMeUser.bio,
                    onTap: () => _openUserProfile(
                      context,
                      caresMeUser,
                      model.currentUser,
                    ),
                  );
                },
              )
            : Container(),
      ),
    );
  }

  _openUserProfile(BuildContext context, User caresMeUser, User currentUser) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          profileMode: caresMeUser.userId == currentUser.userId
              ? ProfileMode.MYSELF
              : ProfileMode.OTHER,
          selectedUser: caresMeUser,
        ),
      ),
    );
  }

  String _getTitleText(BuildContext context, WhoCaresMeMode whoCaresMeMode) {
    String title = '';
    switch (whoCaresMeMode) {
      case WhoCaresMeMode.LIKES:
        title = S.of(context).likes;
        break;
      case WhoCaresMeMode.FOLLOWINGS:
        title = S.of(context).followings;
        break;
      case WhoCaresMeMode.FOLLOWERS:
        title = S.of(context).followers;
        break;
    }
    return title;
  }
}
