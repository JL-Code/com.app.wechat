import 'package:flutter/material.dart';
import './pages/index_page.dart';
import './constants.dart' show AppColors;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IndexPage(),
      theme: ThemeData.light().copyWith(
        primaryColor: Color(AppColors.PrimaryColor),
        cardColor: const Color(AppColors.CardBgColor),
        backgroundColor: Color(AppColors.BackgroundColor),
      ),

      /// 显示debug标志
      debugShowCheckedModeBanner: true,
    );
  }
}
