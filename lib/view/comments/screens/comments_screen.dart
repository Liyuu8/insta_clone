import 'package:flutter/material.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// data models
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

// components
import 'package:insta_clone/view/comments/components/comment_display_part.dart';
import 'package:insta_clone/view/comments/components/comment_input_part.dart';

class CommentsScreen extends StatelessWidget {
  final Post post;
  final User postUser;
  CommentsScreen({@required this.post, @required this.postUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).comments),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            // caption
            CommentDisplayPart(
              postUserPhotoUrl: postUser.photoUrl,
              displayName: postUser.displayName,
              content: post.caption,
              postDateTime: post.postDateTime,
            ),
            // comments
            CommentInputPart(post: post),
          ],
        ),
      ),
    );
  }
}
