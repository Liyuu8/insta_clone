import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// utils
import 'package:insta_clone/utils/functions.dart';

// style
import 'package:insta_clone/style.dart';

// data models
import 'package:insta_clone/data_models/comment.dart';
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

// components
import 'package:insta_clone/view/common/components/comment_rich_text.dart';

// screens
import 'package:insta_clone/view/comments/screens/comments_screen.dart';

// view models
import 'package:insta_clone/view_models/feed_view_model.dart';

class FeedPostDetailsPart extends StatelessWidget {
  final User postUser;
  final Post post;
  FeedPostDetailsPart({@required this.postUser, @required this.post});

  @override
  Widget build(BuildContext context) {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommentRichText(
                  name: postUser.inAppUserName,
                  content: post.caption,
                ),
                Text(
                  createTimeAgoString(post.postDateTime),
                  style: timeAgoTextStyle,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: FaIcon(FontAwesomeIcons.solidHeart),
                onPressed: () => _likeIt(context),
                padding: const EdgeInsets.all(1.0),
              ),
              InkWell(
                onTap: () => null, // TODO: いいねしているユーザー一覧画面に遷移する
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '0 ${S.of(context).likes}',
                    style: numberOfLikesAndCommentsTextStyle,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.comment),
                onPressed: () => _openCommentsScreen(context, post, postUser),
                padding: const EdgeInsets.all(1.0),
              ),
              InkWell(
                onTap: () => _openCommentsScreen(context, post, postUser),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                        future: feedViewModel.getComments(post.postId),
                        builder: (
                          context,
                          AsyncSnapshot<List<Comment>> snapshot,
                        ) =>
                            snapshot.hasData && snapshot.data != null
                                ? Text(
                                    snapshot.data.length.toString() +
                                        ' ' +
                                        S.of(context).comments,
                                    style: numberOfLikesAndCommentsTextStyle,
                                  )
                                : Container(),
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

  _openCommentsScreen(BuildContext context, Post post, User postUser) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CommentsScreen(post: post, postUser: postUser),
      ),
    );
  }

  _likeIt(BuildContext context) async {
    final feedViewModel = context.read<FeedViewModel>();
    await feedViewModel.likeIt(post);
  }
}
