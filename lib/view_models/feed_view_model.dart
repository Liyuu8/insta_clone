import 'package:flutter/material.dart';

// data models
import 'package:insta_clone/data_models/comment.dart';
import 'package:insta_clone/data_models/like.dart';
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
  String caption = '';

  setFeedUser(FeedMode feedMode, User user) => feedUser =
      feedMode == FeedMode.MYSELF_AND_FOLLOWING_USERS ? currentUser : user;

  Future<void> getPosts(FeedMode feedMode) async {
    isProcessing = true;
    notifyListeners();

    posts = await postRepository.getPosts(feedMode, feedUser);

    isProcessing = false;
    notifyListeners();
  }

  Future<User> getPostUserInfo(String userId) async =>
      await userRepository.getUserById(userId);

  Future<void> updatePost(Post post, FeedMode feedMode) async {
    isProcessing = true;
    notifyListeners();

    await postRepository.updatePost(post.copyWith(caption: caption));
    // 投稿を再取得する
    getPosts(feedMode);

    isProcessing = false;
    notifyListeners();
  }

  Future<List<Comment>> getComments(String postId) async {
    return await postRepository.getComments(postId);
  }

  Future<void> likeIt(Post post) async {
    isProcessing = true;
    await postRepository.likeIt(post, currentUser);
    isProcessing = false;
    notifyListeners();
  }

  Future<void> unLikeIt(Post post) async {
    isProcessing = true;
    await postRepository.unLikeIt(post, currentUser);
    isProcessing = false;
    notifyListeners();
  }

  Future<LikeResult> getLikeResult(String likedPostId) async {
    return await postRepository.getLikeResult(likedPostId, currentUser);
  }
}
