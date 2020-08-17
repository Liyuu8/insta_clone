import 'package:flutter/material.dart';

// data models
import 'package:insta_clone/data_models/user.dart';

// repositories
import 'package:insta_clone/models/repositories/user_repository.dart';

// constants
import 'package:insta_clone/utils/constants.dart';

class WhoCaresMeViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  WhoCaresMeViewModel({this.userRepository});

  List<User> caresMeUsers = [];

  Future<void> getCaresMeUsers(WhoCaresMeMode whoCaresMeMode, String id) async {
    caresMeUsers = await userRepository.getCaresMeUsers(whoCaresMeMode, id);
    notifyListeners();
  }
}
