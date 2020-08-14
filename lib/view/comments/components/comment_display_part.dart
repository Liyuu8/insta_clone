import 'package:flutter/material.dart';

// style
import 'package:insta_clone/style.dart';

// utils
import 'package:insta_clone/utils/functions.dart';

// components
import 'package:insta_clone/view/common/components/circle_photo.dart';
import 'package:insta_clone/view/common/components/comment_rich_text.dart';

class CommentDisplayPart extends StatelessWidget {
  final String postUserPhotoUrl;
  final String displayName;
  final String content;
  final DateTime postDateTime;
  CommentDisplayPart({
    @required this.postUserPhotoUrl,
    @required this.displayName,
    @required this.content,
    @required this.postDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CirclePhoto(photoUrl: postUserPhotoUrl, isImageFromFile: false),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CommentRichText(name: displayName, content: content),
              Text(createTimeAgoString(postDateTime), style: timeAgoTextStyle),
            ],
          ),
        )
      ],
    );
  }
}
