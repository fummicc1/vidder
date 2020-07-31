import 'package:flutter/material.dart';
import 'package:vidder/models/user.dart';
import 'package:vidder/repository/user_repository.dart';

class HomeState extends ChangeNotifier {
  User user;

  Future getUser() async {
    final user = await UserRepository.fetchUser(cache: false);
    this.user = user;
    return true;
  }

  Future updateUser(User user, {bool refresh = true}) async {
    try {
      final response = await UserRepository.updateUser(user);
      if (refresh) {
        final user = await UserRepository.fetchUser(cache: false);
        this.user = user;
        notifyListeners();
      }
      return response;
    } catch (error) {
      return Future.error(error);
    }
  }
}