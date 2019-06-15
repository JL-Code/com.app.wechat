import 'package:com_app_wechat/constants.dart';
import 'package:flutter/material.dart';
import 'package:com_app_wechat/widgets/cell.dart';

class DiscoverPage extends StatelessWidget {
  static const String routeName = "/discover";
  static const SEPARATE_SIZE = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(AppColors.BackgroundColor),
      child: Column(
        children: <Widget>[
          Cell(
            avatarPath: "assets/images/ic_social_circle.png",
            title: "朋友圈",
            onPressed: () {
              print("点击了");
            },
          ),
          SizedBox(height: SEPARATE_SIZE),
          Cell(
            avatarPath: "assets/images/ic_quick_scan.png",
            title: "扫一扫",
            onPressed: () {
              print("点击了");
            },
          ),
          SizedBox(height: SEPARATE_SIZE),
          Cell(
            avatarPath: "assets/images/ic_quick_search.png",
            title: "搜一搜",
            onPressed: () {
              print("点击了");
            },
          ),
          SizedBox(height: SEPARATE_SIZE),
          Cell(
            avatarPath: "assets/images/ic_mini_program.png",
            title: "小程序",
            onPressed: () {
              print("点击了");
            },
          ),
        ],
      ),
    );
  }
}
