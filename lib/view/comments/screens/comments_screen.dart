import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// data models
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

// components
import 'package:insta_clone/view/comments/components/comment_display_part.dart';
import 'package:insta_clone/view/comments/components/comment_input_part.dart';
import 'package:insta_clone/view/common/components/dialog/confirm_dialog.dart';

// view model
import 'package:insta_clone/view_models/comments_view_model.dart';

class CommentsScreen extends StatelessWidget {
  final Post post;
  final User postUser;
  CommentsScreen({@required this.post, @required this.postUser});

  @override
  Widget build(BuildContext context) {
    final commentsViewModel =
        Provider.of<CommentsViewModel>(context, listen: false);
    Future(() => commentsViewModel.getComments(post.postId));

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).comments),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // caption part
              CommentDisplayPart(
                postUserPhotoUrl: postUser.photoUrl,
                displayName: postUser.displayName,
                content: post.caption,
                postDateTime: post.postDateTime,
              ),
              Divider(),
              // comments part
              Consumer<CommentsViewModel>(
                builder: (context, model, child) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.comments.length,
                  itemBuilder: (context, index) {
                    final comment = model.comments[index];
                    return FutureBuilder(
                      future: model.getCommentUserInfo(
                        comment.commentUserId,
                      ),
                      builder: (context, AsyncSnapshot<User> snapshot) {
                        final postUser = snapshot.data;
                        return snapshot.hasData
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CommentDisplayPart(
                                  postUserPhotoUrl: postUser.photoUrl,
                                  displayName: postUser.displayName,
                                  content: comment.comment,
                                  postDateTime: comment.commentDateTime,
                                  onLongPressed: () => showConfirmDialog(
                                    context: context,
                                    title: S.of(context).deleteComment,
                                    content: S.of(context).deleteCommentConfirm,
                                    onConfirmed: (isConfirmed) => isConfirmed
                                        ? _deleteComment(context, index)
                                        : null,
                                  ),
                                ),
                              )
                            : Container();
                      },
                    );
                  },
                ),
              ),
              CommentInputPart(post: post),
            ],
          ),
        ),
      ),
    );
  }

  _deleteComment(BuildContext context, int commentIndex) async {
    final commentsViewModel = context.read<CommentsViewModel>();
    await commentsViewModel.deleteComment(post, commentIndex);
  }
}
