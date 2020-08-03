import 'package:flutter/material.dart';
import 'package:vidder/models/post.dart';
import 'package:vidder/repositories/post.dart';
import 'package:video_player/video_player.dart';

class TimelineState extends ChangeNotifier {
  List<Post> posts = [];
  List<VideoPlayerController> videoPlayerControllers = [];

  TimelineState() {
    fetchPosts(cache: false);
  }

  fetchPosts({bool cache = true}) async {
    final List<Post> posts = await PostRepository.fetchPosts(cache: cache);
    this.posts = posts;
    this.videoPlayerControllers = posts.map((post) {
      final videoPlayerController = VideoPlayerController.network(post.videoURL);
      return videoPlayerController;
    }).toList();
    for (int i = 0; i < videoPlayerControllers.length; i++) {
      await videoPlayerControllers[i].initialize();
    }
    notifyListeners();
  }

  Future deletePost({@required Post post, bool refresh = true}) async {
    await PostRepository.deletePost(post: post);
    if (refresh) {
      await fetchPosts(cache: false);
    }
    return Future.value(null);
  }
}