import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// view models
import 'package:insta_clone/view_models/post_view_model.dart';

// components
import 'package:insta_clone/view/post/components/hero_image.dart';
import 'package:insta_clone/view/post/components/post_caption_input_text_field.dart';

// screens
import 'package:insta_clone/view/post/screens/enlarge_image_screen.dart';

class PostCaptionPart extends StatelessWidget {
  final PostCaptionOpenMode from;
  PostCaptionPart({@required this.from});

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();
    final image = Image.file(postViewModel.imageFile);

    return from == PostCaptionOpenMode.FROM_POST
        ? ListTile(
            leading: HeroImage(
              image: image,
              onTap: () => _displayLargeImage(context, image),
            ),
            title: PostCaptionInputTextField(),
          )
        : Container();
  }

  _displayLargeImage(BuildContext context, Image image) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EnlargeImageScreen(image: image),
        ),
      );
}
