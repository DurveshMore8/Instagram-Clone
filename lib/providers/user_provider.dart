import 'package:flutter/material.dart';
import 'package:new_instagram_clone/models/user_model.dart';
import 'package:new_instagram_clone/utils/current_user.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel get getUser => _user!;

  Future<void> refreshUser() async {
    _user = await getCurrentUser();
    notifyListeners();
  }
}
