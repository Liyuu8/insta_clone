import 'package:flutter/material.dart';

// data models
import 'package:insta_clone/data_models/comment.dart';
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';

// repositories
import 'package:insta_clone/models/repositories/post_repository.dart';
import 'package:insta_clone/models/repositories/user_repository.dart';

class CommentsViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  CommentsViewModel({this.userRepository, this.postRepository});

  User get currentUser => UserRepository.currentUser;
  String comment = '';
  List<Comment> comments = [];
  bool isLoading = false;

  Future<void> postComment(Post post) async {
    await postRepository.postComment(post, currentUser, comment);
    getComments(post.postId);
    notifyListeners();
  }

  Future<void> getComments(String postId) async {
    isLoading = true;
    notifyListeners();

    comments = await postRepository.getComments(postId);
    print('CommentsViewModel.getComments: comments is $comments}');

    isLoading = false;
    notifyListeners();
  }

  Future<User> getCommentUserInfo(String commentUserId) async {
    return await userRepository.getUserById(commentUserId);
  }
}
