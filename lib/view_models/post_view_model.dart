import 'package:flutter/material.dart';
import 'dart:io';

// data models
import 'package:insta_clone/data_models/location.dart';

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
  Location location;
  String locationString = '';
  String caption = '';

  bool isProcessing = false;
  bool isImagePicked = false;

  Future<void> pickImage(UploadType uploadType) async {
    isImagePicked = false;
    isProcessing = true;
    notifyListeners();

    imageFile = await postRepository.pickImage(uploadType);
    print('PostViewModel.pickImage: ImageFilePath is ${imageFile.path}');

    location = await postRepository.getCurrentLocation();
    locationString = _toLocationString(location);
    print('PostViewModel.pickImage: locationString is $locationString');

    isImagePicked = imageFile != null;
    isProcessing = false;
    notifyListeners();
  }

  String _toLocationString(Location location) =>
      location.country + ' ' + location.state + ' ' + location.city;
}
