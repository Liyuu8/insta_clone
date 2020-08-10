import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// style
import 'package:insta_clone/style.dart';

// view models
import 'package:insta_clone/view_models/feed_view_model.dart';
import 'package:insta_clone/view_models/post_view_model.dart';

class PostCaptionInputTextField extends StatefulWidget {
  final PostCaptionOpenMode from;
  final String cationBeforeEdited;
  PostCaptionInputTextField({@required this.from, this.cationBeforeEdited});

  @override
  _PostCaptionInputTextFieldState createState() =>
      _PostCaptionInputTextFieldState();
}

class _PostCaptionInputTextFieldState extends State<PostCaptionInputTextField> {
  final _captionController = TextEditingController();

  @override
  void initState() {
    _captionController.addListener(_onCaptionUpdated); // メソッド参照
    _captionController.text = widget.from == PostCaptionOpenMode.FROM_FEED
        ? widget.cationBeforeEdited
        : '';
    super.initState();
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _captionController,
      style: postCaptionTextStyle,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: S.of(context).inputCaption,
        border: InputBorder.none,
      ),
    );
  }

  _onCaptionUpdated() => widget.from == PostCaptionOpenMode.FROM_FEED
      ? context.read<FeedViewModel>().caption = _captionController.text
      : context.read<PostViewModel>().caption = _captionController.text;
}
