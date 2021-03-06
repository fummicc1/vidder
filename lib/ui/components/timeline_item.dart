import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidder/models/post.dart';
import 'package:vidder/states/home.dart';
import 'package:vidder/states/timeline.dart';
import 'package:vidder/ui/components/error_dialog.dart';
import 'package:video_player/video_player.dart';

class TimelineItemWidget extends StatefulWidget {
  final Post post;
  final Key key;

  TimelineItemWidget({this.key, this.post});

  @override
  _TimelineItemWidgetState createState() => _TimelineItemWidgetState();
}

class _TimelineItemWidgetState extends State<TimelineItemWidget> {
  CachedVideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();

    videoPlayerController =
        CachedVideoPlayerController.network(widget.post.videoURL)
          ..initialize()
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: videoPlayerController.value?.aspectRatio,
                    child: CachedVideoPlayer(videoPlayerController),
                  ),
                  Positioned(
                      top: 16,
                      right: 16,
                      width: 40,
                      height: 40,
                      child: deleteButton(context, post: widget.post)),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        widget.post.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .apply(fontWeightDelta: 2),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }

  Widget deleteButton(BuildContext context, {@required Post post}) {
    final TimelineState timelineState = Provider.of(context);
    final HomeState homeState = Provider.of(context);
    if (post.userID == homeState.user.uid) {
      return FlatButton(
        child: const Icon(
          (Icons.delete),
          size: 32,
          color: Colors.black,
        ),
        onPressed: () {
          timelineState.deletePost(post: widget.post).catchError((error) {
            showDialog(context: context, child: errorDialog(context));
          });
        },
      );
    }
    return Container();
  }

  @override
  void didUpdateWidget(TimelineItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    videoPlayerController.play();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }
}
