import 'package:flutter/material.dart';

// style
import 'package:insta_clone/style.dart';

class ProfileRecord extends StatelessWidget {
  final String title;
  final int score;
  ProfileRecord({@required this.title, @required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(title, style: profileRecordTitleTextStyle),
        Text(score.toString(), style: profileRecordScoreTextStyle),
      ],
    );
  }
}
