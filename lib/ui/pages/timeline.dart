import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidder/states/timeline.dart';

class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    final TimelineState timelineState = Provider.of(context);
    return ListView.builder(
      itemCount: timelineState.posts.length,
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}
