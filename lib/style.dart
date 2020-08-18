import 'package:flutter/material.dart';

const TitleFont = 'Billabong';
const RegularFont = 'NotoSansJP_Medium';
const BoldFont = 'NotoSansJP_Bold';

// Theme
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  buttonColor: Colors.white30,
  primaryIconTheme: IconThemeData(color: Colors.white),
  iconTheme: IconThemeData(color: Colors.white),
  fontFamily: RegularFont,
);
final lightTheme = ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.light,
  buttonColor: Colors.white,
  primaryIconTheme: IconThemeData(color: Colors.black),
  iconTheme: IconThemeData(color: Colors.black),
  fontFamily: RegularFont,
);

// Login
const loginTitleTextStyle = TextStyle(
  fontFamily: TitleFont,
  fontSize: 48.0,
);

// Feed
const feedAppBarTitleTextStyle = TextStyle(
  fontFamily: TitleFont,
  fontSize: 28.0,
);
const userCardTitleTextStyle = TextStyle(
  fontFamily: BoldFont,
  fontSize: 14.0,
);
const userCardSubTitleTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 12.0,
);
const numberOfLikesAndCommentsTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 14.0,
);
const timeAgoTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 12.0,
  color: Colors.grey,
);
const commentNameTextStyle = TextStyle(
  fontFamily: BoldFont,
  fontSize: 13.0,
);
const commentContentTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 13.0,
);

// Post
const postCaptionTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 14.0,
);
const postLocationTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 15.0,
);

// Comments
const commentInputTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 14.0,
);

// Profile
const profileRecordScoreTextStyle = TextStyle(
  fontFamily: BoldFont,
  fontSize: 20.0,
);
const profileRecordTitleTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 14.0,
);
const changeProfileImageTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 18.0,
  color: Colors.blueAccent,
);
const editProfileTitleTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 14.0,
);
const profileBioTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 13.0,
);

// Search
const searchPageAppBarTitleTextStyle = TextStyle(
  fontFamily: RegularFont,
  color: Colors.grey,
);
