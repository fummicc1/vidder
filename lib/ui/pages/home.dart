import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidder/states/chat.dart';
import 'package:vidder/states/timeline.dart';
import 'package:vidder/ui/pages/chat.dart';
import 'package:vidder/ui/pages/timeline.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  List<Widget> widgets = [
    ChangeNotifierProvider(child: TimelinePage(), create: (_) => TimelineState(),),
    ChangeNotifierProvider(child: ChatPage(), create: (_) => ChatState()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: widgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
