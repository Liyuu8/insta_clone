import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// view models
import 'package:insta_clone/view_models/post_view_model.dart';

// components
import 'package:insta_clone/view/common/components/dialog/confirm_dialog.dart';
import 'package:insta_clone/view/post/components/post_caption_part.dart';
import 'package:insta_clone/view/post/components/post_location_part.dart';

class PostUpLoadScreen extends StatelessWidget {
  final UploadType uploadType;
  PostUpLoadScreen({this.uploadType});

  @override
  Widget build(BuildContext context) {
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);

    if (!postViewModel.isImagePicked && !postViewModel.isProcessing) {
      Future(() => postViewModel.pickImage(uploadType));
    }
    return WillPopScope(
      onWillPop: () async {
        // バックキーイベントのキャッチ
        _cancelPost(context);
        return true;
      },
      child: Consumer<PostViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            leading: model.isProcessing
                ? Container()
                : IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => _cancelPost(context),
                  ),
            title: model.isProcessing
                ? Text(S.of(context).underProcessing)
                : Text(S.of(context).post),
            actions: <Widget>[
              (model.isProcessing || !model.isImagePicked)
                  ? IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => _cancelPost(context),
                    )
                  : IconButton(
                      icon: Icon(Icons.done),
                      onPressed: () => showConfirmDialog(
                        context: context,
                        title: S.of(context).post,
                        content: S.of(context).postConfirm,
                        onConfirmed: (isConfirmed) =>
                            isConfirmed ? _executePost(context) : null,
                      ),
                    ),
            ],
          ),
          body: model.isProcessing
              ? Center(child: CircularProgressIndicator())
              : model.isImagePicked
                  ? Column(
                      children: [
                        Divider(),
                        PostCaptionPart(from: PostCaptionOpenMode.FROM_POST),
                        Divider(),
                        PostLocationPart(),
                        Divider(),
                      ],
                    )
                  : Container(),
        ),
      ),
    );
  }

  _executePost(BuildContext context) async {
    final postViewModel = context.read<PostViewModel>();
    await postViewModel.executePost();
    Navigator.pop(context);
  }

  _cancelPost(BuildContext context) {
    final postViewModel = context.read<PostViewModel>();
    postViewModel.cancelPost();
    Navigator.pop(context);
  }
}
