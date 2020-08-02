import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// view models
import 'package:insta_clone/view_models/post_view_model.dart';

class PostUpLoadScreen extends StatelessWidget {
  final UploadType uploadType;
  PostUpLoadScreen({this.uploadType});

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();

    if (!postViewModel.isImagePicked && !postViewModel.isProcessing) {
      Future(() => postViewModel.pickImage(uploadType));
    }
    return Scaffold(
      body: Center(
        child: Text('PostUpLoadScreen'),
      ),
    );
  }
}
