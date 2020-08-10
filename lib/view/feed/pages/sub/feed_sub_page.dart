import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// view models
import 'package:insta_clone/view_models/feed_view_model.dart';

class FeedSubPage extends StatelessWidget {
  final FeedMode feedMode;
  FeedSubPage({@required this.feedMode});

  @override
  Widget build(BuildContext context) {
    // read: ビルドエラーが発生する、watch: ビルドがループ処理される
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    feedViewModel.setFeedUser(feedMode, null); // TODO: user情報取得
    Future(() => feedViewModel.getPosts(feedMode));

    return Scaffold(
      body: Center(
        child: Text('FeedSubPage'),
      ),
    );
  }
}
