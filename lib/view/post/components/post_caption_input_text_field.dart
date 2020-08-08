import 'package:flutter/material.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:provider/provider.dart';

// style
import 'package:insta_clone/style.dart';

// view models
import 'package:insta_clone/view_models/post_view_model.dart';

class PostCaptionInputTextField extends StatefulWidget {
  @override
  _PostCaptionInputTextFieldState createState() =>
      _PostCaptionInputTextFieldState();
}

class _PostCaptionInputTextFieldState extends State<PostCaptionInputTextField> {
  final _captionController = TextEditingController();

  @override
  void initState() {
    _captionController.addListener(_onCaptionUpdated); // メソッド参照
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

  _onCaptionUpdated() {
    final postViewModel = context.read<PostViewModel>();
    postViewModel.caption = _captionController.text;
    print('PostCaptionInputTextField._onCaptionUpdated: '
        'caption is ${postViewModel.caption}');
  }
}
