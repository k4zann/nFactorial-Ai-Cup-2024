import 'package:flutter/material.dart';
import 'package:route_vision/ui/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RouteVision',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple[900],
        hintColor: Colors.yellow,
        scaffoldBackgroundColor: Color(0xFF1C1B29),
      ),
      home: HomePage(),
    );
  }
}

