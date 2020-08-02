import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// components
import 'package:insta_clone/view/common/components/button_with_icon.dart';

// screens
import 'package:insta_clone/view/post/screens/post_up_load_screen.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ButtonWithIcon(
                onPressed: () =>
                    _openPostUpLoadScreen(UploadType.GALLERY, context),
                iconData: FontAwesomeIcons.images,
                label: S.of(context).gallery,
              ),
              SizedBox(height: 24.0),
              ButtonWithIcon(
                onPressed: () =>
                    _openPostUpLoadScreen(UploadType.CAMERA, context),
                iconData: FontAwesomeIcons.camera,
                label: S.of(context).camera,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _openPostUpLoadScreen(UploadType uploadType, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PostUpLoadScreen(uploadType: uploadType),
      ),
    );
  }
}
