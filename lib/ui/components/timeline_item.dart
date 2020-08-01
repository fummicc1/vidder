import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vidder/models/post.dart';
import 'package:video_player/video_player.dart';

class TimelineItemWidget extends StatefulWidget {
  final Post post;

  TimelineItemWidget({this.post});

  @override
  _TimelineItemWidgetState createState() => _TimelineItemWidgetState();
}

class _TimelineItemWidgetState extends State<TimelineItemWidget> {
  VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.post.videoURL)
      ..initialize()
      ..setLooping(true)
      ..addListener(() {
        setState(() {});
      })
      ..play();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: videoPlayerController.value?.aspectRatio,
            child: VideoPlayer(videoPlayerController),
          ),
        )
      ),
    );
  }

  @override
  void didUpdateWidget(TimelineItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    videoPlayerController.play();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }
}
