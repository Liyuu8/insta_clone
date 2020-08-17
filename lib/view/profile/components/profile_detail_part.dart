import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// generated
import 'package:insta_clone/generated/l10n.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// components
import 'package:insta_clone/view/common/components/circle_photo.dart';
import 'package:insta_clone/view/profile/components/sub/profile_bio.dart';
import 'package:insta_clone/view/profile/components/sub/profile_record.dart';

// view models
import 'package:insta_clone/view_models/profile_view_model.dart';

class ProfileDetailPart extends StatelessWidget {
  final ProfileMode profileMode;
  ProfileDetailPart({@required this.profileMode});

  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    final profileUser = profileViewModel.profileUser;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CirclePhoto(
                  photoUrl: profileUser.photoUrl,
                  radius: 30.0,
                  isImageFromFile: false,
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FutureBuilder(
                        future: profileViewModel.getNumberOfPosts(),
                        builder: (context, AsyncSnapshot<int> snapshot) {
                          final numberOfPosts =
                              snapshot.hasData ? snapshot.data : 0;
                          return ProfileRecord(
                            title: S.of(context).post,
                            score: numberOfPosts,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: profileViewModel.getNumberOfFollowers(),
                        builder: (context, AsyncSnapshot<int> snapshot) {
                          final numberOfFollowers =
                              snapshot.hasData ? snapshot.data : 0;
                          return ProfileRecord(
                            title: S.of(context).followers,
                            score: numberOfFollowers,
                            whoCaresMeMode: WhoCaresMeMode.FOLLOWERS,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: profileViewModel.getNumberOfFollowings(),
                        builder: (context, AsyncSnapshot<int> snapshot) {
                          final numberOfFollowings =
                              snapshot.hasData ? snapshot.data : 0;
                          return ProfileRecord(
                            title: S.of(context).followings,
                            score: numberOfFollowings,
                            whoCaresMeMode: WhoCaresMeMode.FOLLOWINGS,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          ProfileBio(profileMode: profileMode),
        ],
      ),
    );
  }
}
