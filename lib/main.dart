import 'package:flutter/material.dart';
import './pages/index_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IndexPage(),
      theme: ThemeData.light().copyWith(
        // primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
