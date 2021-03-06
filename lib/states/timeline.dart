import 'package:flutter/material.dart';
import 'package:vidder/models/post.dart';
import 'package:vidder/repositories/post.dart';
import 'package:video_player/video_player.dart';

class TimelineState extends ChangeNotifier {
  List<Post> posts = [];

  TimelineState() {
    fetchPosts(cache: false);
  }

  fetchPosts({bool cache = true}) async {
    final List<Post> posts = await PostRepository.fetchPosts(cache: cache);
    this.posts = posts;
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