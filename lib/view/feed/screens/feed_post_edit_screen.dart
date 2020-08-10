import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// data models
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// components
import 'package:insta_clone/view/common/components/dialog/confirm_dialog.dart';
import 'package:insta_clone/view/common/components/user_card.dart';
import 'package:insta_clone/view/post/components/post_caption_part.dart';

// view models
import 'package:insta_clone/view_models/feed_view_model.dart';

class FeedPostEditScreen extends StatelessWidget {
  final User postUser;
  final Post post;
  final FeedMode feedMode;
  FeedPostEditScreen({
    @required this.postUser,
    @required this.post,
    @required this.feedMode,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedViewModel>(
      builder: (_, model, child) => Scaffold(
        appBar: AppBar(
          leading: model.isProcessing
              ? Container()
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
          title: model.isProcessing
              ? Text(S.of(context).underProcessing)
              : Text(S.of(context).editInfo),
          actions: <Widget>[
            model.isProcessing
                ? Container()
                : IconButton(
                    icon: Icon(Icons.done),
                    onPressed: () => showConfirmDialog(
                      context: context,
                      title: S.of(context).editPost,
                      content: S.of(context).editPostConfirm,
                      onConfirmed: (isConfirmed) =>
                          isConfirmed ? _updatePost(context) : null,
                    ),
                  ),
          ],
        ),
        body: model.isProcessing
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    UserCard(
                      photoUrl: postUser.photoUrl,
                      title: postUser.inAppUserName,
                      subTitle: post.locationString,
                      onTap: null,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PostCaptionPart(
                        from: PostCaptionOpenMode.FROM_FEED,
                        post: post,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  _updatePost(BuildContext context) async {
    final feedViewModel = context.read<FeedViewModel>();
    await feedViewModel.updatePost(post, feedMode);
    Navigator.pop(context);
  }
}
