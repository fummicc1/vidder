import 'package:flutter/material.dart';
import 'package:vidder/models/chat.dart';
import 'package:vidder/repositories/chat.dart';
import 'package:vidder/repositories/user.dart';

class ChatState extends ChangeNotifier {

  List<Chat> chats = [];

  ChatState() {
    UserRepository.fetchUser().then((user) async {
      final chats = await ChatRepository.fetchChatsOfUser(userID: user.uid);
      this.chats = chats;
      notifyListeners();
    });
  }


}