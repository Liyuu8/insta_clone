import 'package:flutter/material.dart';
import 'package:share/share.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// data models
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

// components
import 'package:insta_clone/view/common/components/user_card.dart';

// screens
import 'package:insta_clone/view/feed/screens/feed_post_edit_screen.dart';

class FeedPostHeaderPart extends StatelessWidget {
  final User postUser;
  final User currentUser;
  final Post post;
  final FeedMode feedMode;
  FeedPostHeaderPart({
    @required this.postUser,
    @required this.currentUser,
    @required this.post,
    @required this.feedMode,
  });

  @override
  Widget build(BuildContext context) {
    return UserCard(
      photoUrl: postUser.photoUrl,
      title: postUser.inAppUserName,
      subTitle: post.locationString,
      onTap: () => null, // TODO:
      trailing: PopupMenuButton(
        icon: Icon(Icons.more_vert),
        onSelected: (selected) => _onPopupMenuSelected(context, selected),
        itemBuilder: (context) => postUser.userId == currentUser.userId
            ? [
                PopupMenuItem(
                  value: PostMenu.EDIT,
                  child: Text(S.of(context).edit),
                ),
                PopupMenuItem(
                  value: PostMenu.DELETE,
                  child: Text(S.of(context).delete),
                ),
                PopupMenuItem(
                  value: PostMenu.SHARE,
                  child: Text(S.of(context).share),
                ),
              ]
            : [
                PopupMenuItem(
                  value: PostMenu.SHARE,
                  child: Text(S.of(context).share),
                ),
              ],
      ),
    );
  }

  _onPopupMenuSelected(BuildContext context, PostMenu selectedMenu) {
    switch (selectedMenu) {
      case PostMenu.EDIT:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FeedPostEditScreen(
              postUser: postUser,
              post: post,
              feedMode: feedMode,
            ),
          ),
        );
        break;
      case PostMenu.DELETE:
        // TODO:
        break;
      case PostMenu.SHARE:
        Share.share(post.imageUrl, subject: post.caption);
        break;
      default:
    }
  }
}
