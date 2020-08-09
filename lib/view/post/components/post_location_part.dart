import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// style
import 'package:insta_clone/style.dart';

// data models
import 'package:insta_clone/data_models/location.dart';

// view models
import 'package:insta_clone/view_models/post_view_model.dart';

// screens
import 'package:insta_clone/view/post/screens/map_screen.dart';

class PostLocationPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.mapMarkedAlt),
          onPressed: () => _openMapScreen(context, postViewModel.location),
        ),
        title: Text(postViewModel.locationString, style: postLocationTextStyle),
        subtitle: _latLonPart(context, postViewModel.location),
      ),
    );
  }

  _latLonPart(BuildContext context, Location location) {
    const space = 8.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: space),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Chip(label: Text(S.of(context).latitude)),
            SizedBox(width: space),
            Text(location.latitude.toStringAsFixed(2)),
          ],
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Chip(label: Text(S.of(context).longitude)),
            SizedBox(width: space),
            Text(location.longitude.toStringAsFixed(2)),
          ],
        ),
      ],
    );
  }

  _openMapScreen(BuildContext context, Location location) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MapScreen(location: location)),
    );
  }
}
