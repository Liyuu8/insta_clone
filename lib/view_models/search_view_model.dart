import 'package:flutter/material.dart';

// data models
import 'package:insta_clone/data_models/user.dart';

// repositories
import 'package:insta_clone/models/repositories/user_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  SearchViewModel({this.userRepository});

  List<User> soughtUsers = [];

  Future<void> searchUsers(String query) async {
    soughtUsers = await userRepository.searchUsers(query);
  }
}
