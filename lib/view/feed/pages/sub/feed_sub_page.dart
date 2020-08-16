import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// data models
import 'package:insta_clone/data_models/user.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// view models
import 'package:insta_clone/view_models/feed_view_model.dart';

// components
import 'package:insta_clone/view/feed/components/feed_post_tile.dart';

class FeedSubPage extends StatelessWidget {
  final FeedMode feedMode;
  final User feedUser;
  final int index;
  FeedSubPage({@required this.feedMode, this.feedUser, @required this.index});

  @override
  Widget build(BuildContext context) {
    // read: ビルドエラーが発生する、watch: ビルドがループ処理される
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    feedViewModel.setFeedUser(feedMode, feedUser);
    Future(() => feedViewModel.getPosts(feedMode));

    return Consumer<FeedViewModel>(
      builder: (context, model, child) => feedViewModel.isProcessing
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => feedViewModel.getPosts(feedMode),
              child: ScrollablePositionedList.builder(
                initialScrollIndex: index,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: model.posts.length,
                itemBuilder: (context, index) =>
                    FeedPostTile(feedMode: feedMode, post: model.posts[index]),
              ),
            ),
    );
  }
}
