import 'package:flutter/material.dart';

// data models
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

// repositories
import 'package:insta_clone/models/repositories/post_repository.dart';
import 'package:insta_clone/models/repositories/user_repository.dart';

class FeedViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  FeedViewModel({this.userRepository, this.postRepository});

  bool isProcessing = false;
  List<Post> posts = [];
  User get currentUser => UserRepository.currentUser;
  User feedUser;

  setFeedUser(FeedMode feedMode, User user) => feedUser =
      feedMode == FeedMode.MYSELF_AND_FOLLOWING_USERS ? currentUser : user;

  Future<void> getPosts(FeedMode feedMode) async {
    isProcessing = true;
    notifyListeners();

    posts = await postRepository.getPosts(feedMode, feedUser);

    isProcessing = false;
    notifyListeners();
  }
}
