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
import 'package:insta_clone/data_models/like.dart';
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

// components
import 'package:insta_clone/view/common/components/comment_rich_text.dart';

// screens
import 'package:insta_clone/view/comments/screens/comments_screen.dart';
import 'package:insta_clone/view/who_cares_me/screens/who_cares_me_screen.dart';

// view models
import 'package:insta_clone/view_models/feed_view_model.dart';

// constants
import 'package:insta_clone/utils/constants.dart';

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
              FutureBuilder(
                future: feedViewModel.getLikeResult(post.postId),
                builder: (context, AsyncSnapshot<LikeResult> snapshot) {
                  final likeResult = snapshot.data;
                  return snapshot.hasData && snapshot.data != null
                      ? Row(
                          children: <Widget>[
                            likeResult.isLikedToThisPost
                                ? IconButton(
                                    icon: FaIcon(FontAwesomeIcons.solidHeart),
                                    onPressed: () => !feedViewModel.isProcessing
                                        ? _unLikeIt(context)
                                        : null,
                                    padding: const EdgeInsets.all(1.0),
                                  )
                                : IconButton(
                                    icon: FaIcon(FontAwesomeIcons.heart),
                                    onPressed: () => !feedViewModel.isProcessing
                                        ? _likeIt(context)
                                        : null,
                                    padding: const EdgeInsets.all(1.0),
                                  ),
                            GestureDetector(
                              onTap: () => _checkLikesUsers(context),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  likeResult.likes.length.toString() +
                                      ' ' +
                                      S.of(context).likes,
                                  style: numberOfLikesAndCommentsTextStyle,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container();
                },
              ),
              SizedBox(width: 8.0),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.comment),
                onPressed: () => _openCommentsScreen(context),
                padding: const EdgeInsets.all(1.0),
              ),
              GestureDetector(
                onTap: () => _openCommentsScreen(context),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FutureBuilder(
                    future: feedViewModel.getComments(post.postId),
                    builder: (context, AsyncSnapshot<List<Comment>> snapshot) =>
                        snapshot.hasData && snapshot.data != null
                            ? Text(
                                snapshot.data.length.toString() +
                                    ' ' +
                                    S.of(context).comments,
                                style: numberOfLikesAndCommentsTextStyle,
                              )
                            : Container(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _openCommentsScreen(BuildContext context) {
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

  _unLikeIt(BuildContext context) async {
    final feedViewModel = context.read<FeedViewModel>();
    await feedViewModel.unLikeIt(post);
  }

  _checkLikesUsers(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WhoCaresMeScreen(
          whoCaresMeMode: WhoCaresMeMode.LIKES,
          id: post.postId,
        ),
      ),
    );
  }
}
