import 'package:flutter/material.dart';

// models
import 'package:insta_clone/models/repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  LoginViewModel({this.userRepository});
}
