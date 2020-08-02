import 'package:flutter/material.dart';
import 'dart:io';

// repositories
import 'package:insta_clone/models/repositories/post_repository.dart';
import 'package:insta_clone/models/repositories/user_repository.dart';

// utils
import 'package:insta_clone/utils/constants.dart';

class PostViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  PostViewModel({this.userRepository, this.postRepository});

  File imageFile;

  bool isProcessing = false;
  bool isImagePicked = false;

  Future<void> pickImage(UploadType uploadType) async {
    isImagePicked = false;
    isProcessing = true;
    notifyListeners();

    imageFile = await postRepository.pickImage(uploadType);
    // TODO: delete
    print('PostViewModel.pickImage: ImageFilePath is ${imageFile.path}');

    // TODO: 位置情報の取得

    isImagePicked = imageFile != null;
    isProcessing = false;
    notifyListeners();
  }
}
