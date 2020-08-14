import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// style
import 'package:insta_clone/style.dart';

// data models
import 'package:insta_clone/data_models/post.dart';

// view models
import 'package:insta_clone/view_models/comments_view_model.dart';

// components
import 'package:insta_clone/view/common/components/circle_photo.dart';

class CommentInputPart extends StatefulWidget {
  final Post post;
  CommentInputPart({@required this.post});

  @override
  _CommentInputPartState createState() => _CommentInputPartState();
}

class _CommentInputPartState extends State<CommentInputPart> {
  final _commentInputController = TextEditingController();
  bool _isPostEnabled = false;

  @override
  void initState() {
    _commentInputController.addListener(_onCommentChanged);
    super.initState();
  }

  @override
  void dispose() {
    _commentInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentsViewModel = context.watch<CommentsViewModel>();
    final cardColor = Theme.of(context).cardColor;
    final commenter = commentsViewModel.currentUser;

    return Card(
      color: cardColor,
      child: ListTile(
        leading: CirclePhoto(
          photoUrl: commenter.photoUrl,
          isImageFromFile: false,
        ),
        title: TextField(
          maxLines: null,
          controller: _commentInputController,
          style: commentInputTextStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: S.of(context).addComment,
          ),
        ),
        trailing: FlatButton(
          child: Text(S.of(context).post),
          onPressed: _isPostEnabled ? () => _postComment(widget.post) : null,
          color: _isPostEnabled ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }

  _onCommentChanged() {
    final commentsViewModel = context.read<CommentsViewModel>();
    commentsViewModel.comment = _commentInputController.text;
    setState(() {
      _isPostEnabled = _commentInputController.text.length > 0;
    });
  }

  _postComment(Post post) async {
    final commentsViewModel = context.read<CommentsViewModel>();
    await commentsViewModel.postComment(post);
    _commentInputController.clear();
  }
}
