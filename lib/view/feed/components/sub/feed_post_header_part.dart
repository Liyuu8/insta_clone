import 'package:flutter/material.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// data models
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

// components
import 'package:insta_clone/view/common/components/user_card.dart';

class FeedPostHeaderPart extends StatelessWidget {
  final User postUser;
  final User currentUser;
  final Post post;
  FeedPostHeaderPart({
    @required this.postUser,
    @required this.currentUser,
    @required this.post,
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
        onSelected: (value) => _onPopupMenuSelected(context, value),
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

  // TODO:
  _onPopupMenuSelected(BuildContext context, value) {}
}
