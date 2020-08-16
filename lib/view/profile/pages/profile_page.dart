import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// data models
import 'package:insta_clone/data_models/user.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// view models
import 'package:insta_clone/view_models/profile_view_model.dart';

// components
import 'package:insta_clone/view/profile/components/profile_setting_part.dart';
import 'package:insta_clone/view/profile/components/profile_detail_part.dart';
import 'package:insta_clone/view/profile/components/profile_posts_grid_part.dart';

class ProfilePage extends StatelessWidget {
  final ProfileMode profileMode;
  final User selectedUser;
  ProfilePage({@required this.profileMode, this.selectedUser});

  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.setProfileUser(profileMode, selectedUser);

    Future(() => profileViewModel.getPosts());

    return Scaffold(
      body: Consumer<ProfileViewModel>(
        builder: (context, model, child) => CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(model.profileUser.inAppUserName),
              pinned: true,
              floating: true,
              actions: <Widget>[
                ProfileSettingPart(profileMode: profileMode),
              ],
              expandedHeight: 280.0,
              flexibleSpace: FlexibleSpaceBar(
                background: ProfileDetailPart(profileMode: profileMode),
              ),
            ),
            ProfilePostsGridPart(posts: model.posts),
          ],
        ),
      ),
    );
  }
}
