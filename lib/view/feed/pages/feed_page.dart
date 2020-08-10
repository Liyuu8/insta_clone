import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// style
import 'package:insta_clone/style.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// pages
import 'package:insta_clone/view/feed/pages/sub/feed_sub_page.dart';

// screens
import 'package:insta_clone/view/post/screens/post_up_load_screen.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            S.of(context).appTitle,
            style: feedAppBarTitleTextStyle,
          ),
        ),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.camera),
          onPressed: () => _launchCamera(context),
        ),
      ),
      body: FeedSubPage(feedMode: FeedMode.MYSELF_AND_FOLLOWING_USERS),
    );
  }

  _launchCamera(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PostUpLoadScreen(uploadType: UploadType.CAMERA),
      ),
    );
  }
}
