import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidder/states/home.dart';
import 'package:vidder/ui/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeState(),
      child: MaterialApp(
        title: 'Vidder',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}