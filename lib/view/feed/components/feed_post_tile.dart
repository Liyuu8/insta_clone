import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// data models
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// view models
import 'package:insta_clone/view_models/feed_view_model.dart';

// components
import 'package:insta_clone/view/feed/components/sub/feed_post_header_part.dart';
import 'package:insta_clone/view/feed/components/sub/feed_post_details_part.dart';
import 'package:insta_clone/view/feed/components/sub/image_from_url.dart';

class FeedPostTile extends StatelessWidget {
  final FeedMode feedMode;
  final Post post;
  FeedPostTile({this.feedMode, this.post});

  @override
  Widget build(BuildContext context) {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);

    return FutureBuilder(
      future: feedViewModel.getPostUserInfo(post.userId),
      builder: (context, AsyncSnapshot<User> snapshot) =>
          snapshot.hasData && snapshot.data != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FeedPostHeaderPart(
                      postUser: snapshot.data,
                      currentUser: feedViewModel.currentUser,
                      post: post,
                      feedMode: feedMode,
                    ),
                    ImageFromUrl(imageUrl: post.imageUrl),
                    FeedPostDetailsPart(postUser: snapshot.data, post: post),
                    Divider(),
                  ],
                )
              : Container(),
    );
  }
}
