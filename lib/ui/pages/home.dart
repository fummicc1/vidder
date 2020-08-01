import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidder/repositories/user.dart';
import 'package:vidder/states/chat.dart';
import 'package:vidder/states/create_post.dart';
import 'package:vidder/states/home.dart';
import 'package:vidder/states/timeline.dart';
import 'package:vidder/ui/pages/chat.dart';
import 'package:vidder/ui/pages/create_post.dart';
import 'package:vidder/ui/pages/timeline.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> titles = [Text("タイムライン"), Text("メッセージ")];

  List<Widget> _widgets = [
    TimelinePage(),
    ChatPage(),
  ];

  @override
  void initState() {
    super.initState();
    final HomeState homeState = Provider.of(context, listen: false);
    homeState.getUser().catchError((error) {
      if (error is UserRepositoryError) {
        if ((error as UserRepositoryError) == UserRepositoryError.NoUser) {
          homeState.createAnonymousUser();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomeState homeState = Provider.of(context);

    if (homeState.user == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: titles[_currentIndex],
      ),
      body: _widgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("ホーム")),
          BottomNavigationBarItem(
              icon: Icon(Icons.email), title: Text("メッセージ")),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: floatingActionButton(context),
    );
  }

  Widget floatingActionButton(BuildContext context) {
    if (_currentIndex == 0) {
      return FloatingActionButton(
        elevation: 8,
        child: Icon(Icons.create, size: 32),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            settings: const RouteSettings(name: "/create_post"),
            builder: (context) => ChangeNotifierProvider(
                create: (_) => CreatePostState(), child: CreatePostPage()),
            fullscreenDialog: true,
          ));
        },
      );
    } else if (_currentIndex == 1) {
      return null;
    }
  }
}
