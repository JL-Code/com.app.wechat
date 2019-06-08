import 'package:flutter/material.dart';
import './pages/index_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IndexPage(),
      // theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.white)),
      debugShowCheckedModeBanner: false,
    );
  }
}
