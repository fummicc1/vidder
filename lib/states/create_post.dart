import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vidder/models/post.dart';
import 'package:vidder/repositories/post.dart';
import 'package:vidder/repositories/user.dart';
import 'package:video_player/video_player.dart';

class CreatePostState extends ChangeNotifier {
  String title;
  File videoFile;
  VideoPlayerController videoPlayerController;

  updateTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  updateFile(File file) async {
    this.videoFile = file;
    this.videoPlayerController = VideoPlayerController.file(file);
    await videoPlayerController.initialize();
    notifyListeners();
  }

  Future startPlayVideo() async {
    return videoPlayerController?.play();
  }

  Future createPost() async {
    try {
      final user = await UserRepository.fetchUser(cache: true);
      final Post post = Post(userID: user.uid, title: title);
      return PostRepository.createPost(post: post, file: videoFile);
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }
}
