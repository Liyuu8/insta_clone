import 'package:flutter/material.dart';

// data models
import 'package:insta_clone/data_models/user.dart';

// constants
import 'package:insta_clone/utils/constants.dart';

// pages
import 'package:insta_clone/view/profile/pages/profile_page.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileMode profileMode;
  final User selectedUser;
  ProfileScreen({@required this.profileMode, @required this.selectedUser});

  @override
  Widget build(BuildContext context) {
    return ProfilePage(profileMode: profileMode, selectedUser: selectedUser);
  }
}
