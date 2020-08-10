import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// utils
import 'package:insta_clone/utils/functions.dart';

// style
import 'package:insta_clone/style.dart';

// data models
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

// components
import 'package:insta_clone/view/common/components/comment_rich_text.dart';

class FeedPostDetailsPart extends StatelessWidget {
  final User postUser;
  final Post post;
  FeedPostDetailsPart({@required this.postUser, @required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            // 投稿者名とキャプション
            child: CommentRichText(
              name: postUser.inAppUserName,
              content: post.caption,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: FaIcon(FontAwesomeIcons.solidHeart),
                onPressed: () => null, // TODO: いいねをつける
                padding: const EdgeInsets.all(1.0),
              ),
              InkWell(
                onTap: () => null, // TODO: いいねしているユーザー一覧画面に遷移する
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '0 ${S.of(context).likes}',
                    style: numberOfLikesAndCommentsTextStyle,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.comment),
                onPressed: () => null, // TODO: コメントを入力する画面に遷移する
                padding: const EdgeInsets.all(1.0),
              ),
              InkWell(
                onTap: () => null, // TODO: コメントしているユーザー一覧画面に遷移する
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '0 ${S.of(context).comments}',
                        style: numberOfLikesAndCommentsTextStyle,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        createTimeAgoString(post.postDateTime),
                        style: timeAgoTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
