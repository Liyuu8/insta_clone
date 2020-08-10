import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// view models
import 'package:insta_clone/view_models/post_view_model.dart';

// components
import 'package:insta_clone/view/post/components/hero_image.dart';
import 'package:insta_clone/view/post/components/post_caption_input_text_field.dart';
import 'package:insta_clone/view/feed/components/sub/image_from_url.dart';

// screens
import 'package:insta_clone/view/post/screens/enlarge_image_screen.dart';

// data models
import 'package:insta_clone/data_models/post.dart';

class PostCaptionPart extends StatelessWidget {
  final PostCaptionOpenMode from;
  final Post post;
  PostCaptionPart({@required this.from, this.post});

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();

    return from == PostCaptionOpenMode.FROM_POST
        ? ListTile(
            leading: HeroImage(
              image: Image.file(postViewModel.imageFile),
              onTap: () => _displayLargeImage(
                context,
                Image.file(postViewModel.imageFile),
              ),
            ),
            title: PostCaptionInputTextField(from: from),
          )
        : Column(
            children: <Widget>[
              ImageFromUrl(imageUrl: post.imageUrl),
              PostCaptionInputTextField(
                from: from,
                cationBeforeEdited: post.caption,
              ),
            ],
          );
  }

  _displayLargeImage(BuildContext context, Image image) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EnlargeImageScreen(image: image),
        ),
      );
}
