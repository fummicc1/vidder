import 'package:flutter/material.dart';
import 'package:vidder/models/post.dart';
import 'package:vidder/repositories/post.dart';

class TimelineState extends ChangeNotifier {
  List<Post> posts = [];

  TimelineState() {
    fetchPosts();
  }

  fetchPosts() async {
    final posts = await PostRepository.fetchPosts();
    this.posts = posts;
    notifyListeners();
  }
}