import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vidder/models/user.dart';
import 'package:vidder/repositories/user.dart';

class HomeState extends ChangeNotifier {
  User user;

  Future getUser() async {
    final user = await UserRepository.fetchUser(cache: false);
    this.user = user;
    notifyListeners();
    return true;
  }

  Future updateUser(User user, {bool refresh = true}) async {
    try {
      final response = await UserRepository.updateUser(user);
      if (refresh) {
        getUser();
      }
      return response;
    } catch (error) {
      return Future.error(error);
    }
  }

  Future createAnonymousUser() async {
    try {
      final User user = await UserRepository.signInUserAnonymously();
      this.user = user;
      notifyListeners();
      return Future.value(user);
    } catch (error) {
      return Future.error(error);
    }
  }
}