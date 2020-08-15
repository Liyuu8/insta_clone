import 'package:flutter/material.dart';

// models
import 'package:insta_clone/models/repositories/post_repository.dart';
import 'package:insta_clone/models/repositories/user_repository.dart';

// data models
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  ProfileViewModel({this.userRepository, this.postRepository});

  User profileUser;
  User get currentUser => UserRepository.currentUser;
  bool isProcessing = false;
  List<Post> posts = [];

  void setProfileUser(ProfileMode profileMode, User selectedUser) {
    profileUser =
        profileMode == ProfileMode.MYSELF ? currentUser : selectedUser;
  }

  Future<void> getPosts() async {
    isProcessing = true;
    notifyListeners();

    posts = await postRepository.getPosts(
      FeedMode.PROFILE_USER_ONLY,
      profileUser,
    );
    isProcessing = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await userRepository.signOut();
    notifyListeners();
  }
}
