import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidder/states/chat.dart';
import 'package:vidder/states/home.dart';
import 'package:vidder/states/timeline.dart';
import 'package:vidder/ui/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeState(),
        ),
        ChangeNotifierProvider(
          create: (_) => TimelineState(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatState(),
        )
      ],
      child: ChangeNotifierProvider(
        create: (_) => HomeState(),
        child: MaterialApp(
          title: 'Vidder',
          theme: ThemeData(
              backgroundColor: Color(0xFF5FCAF4),
              scaffoldBackgroundColor: Color(0xFF5FCAF4),
              appBarTheme: AppBarTheme(
                color: Color(0xFF5FCAF4),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Color(0xFF5FCAF4),
                  selectedItemColor: Colors.black
              ),
              primaryColor: Color(0xFF16B4F2),
              buttonColor: Color(0xFF5FCAF4),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Color(0xFF5FCAF4),
                  foregroundColor: Colors.black
              )
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}