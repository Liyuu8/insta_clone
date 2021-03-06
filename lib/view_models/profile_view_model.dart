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
  bool isFollowingProfileUser = false;

  void setProfileUser(ProfileMode profileMode, User selectedUser) {
    profileUser =
        profileMode == ProfileMode.MYSELF ? currentUser : selectedUser;
    if (profileMode == ProfileMode.OTHER) {
      _checkIsFollowing();
    }
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

  Future<int> getNumberOfPosts() async {
    final profileUserPosts = await postRepository.getPosts(
      FeedMode.PROFILE_USER_ONLY,
      profileUser,
    );
    return profileUserPosts.length;
  }

  Future<int> getNumberOfFollowers() async {
    final followers = await userRepository.getFollowerUserIds(profileUser);
    return followers.length;
  }

  Future<int> getNumberOfFollowings() async {
    final followings = await userRepository.getFollowingUserIds(profileUser);
    return followings.length;
  }

  Future<String> pickProfileImage() async {
    final imageUrl = await postRepository.pickImage(UploadType.GALLERY);
    return imageUrl.path;
  }

  Future<void> updateProfile(
    String updatedName,
    String updatedBio,
    String updatedPhotoUrl,
    bool isImageFromFile,
  ) async {
    isProcessing = true;
    notifyListeners();

    await userRepository.updateProfile(
      profileUser,
      updatedName,
      updatedBio,
      updatedPhotoUrl,
      isImageFromFile,
    );
    await userRepository.updateCurrentUserInfo(profileUser.userId);
    profileUser = currentUser;

    isProcessing = false;
    notifyListeners();
  }

  Future<void> followProfileUser() async {
    await userRepository.follow(profileUser);
    isFollowingProfileUser = true;
    notifyListeners();
  }

  Future<void> unFollowProfileUser() async {
    await userRepository.unFollow(profileUser);
    isFollowingProfileUser = false;
    notifyListeners();
  }

  Future<void> _checkIsFollowing() async {
    isFollowingProfileUser = await userRepository.checkIsFollowing(profileUser);
    notifyListeners();
  }
}
