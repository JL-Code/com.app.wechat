import 'package:com_app_wechat/constants.dart';
import 'package:flutter/material.dart';
import 'package:com_app_wechat/widgets/cell.dart';

class DiscoverPage extends StatelessWidget {
  static const String routeName = "/discover";
  static const SEPARATE_SIZE = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(AppColors.BackgroundColor),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Cell(
              iconPath: "assets/images/ic_social_circle.png",
              title: "朋友圈",
              valueWidget: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Cell.iconTag("https://randomuser.me/api/portraits/men/85.jpg",
                      showDot: true, isBig: true),
                ],
              ),
              onPressed: () {
                print("点击了");
              },
            ),
            SizedBox(height: SEPARATE_SIZE),
            Cell(
              iconPath: "assets/images/ic_quick_scan.png",
              title: "扫一扫",
              onPressed: () {
                print("点击了");
              },
            ),
            Cell(
              iconPath: "assets/images/ic_shake_phone.png",
              title: "摇一摇",
              onPressed: () {
                print("点击了");
              },
            ),
            SizedBox(height: SEPARATE_SIZE),
            Cell(
              iconPath: "assets/images/ic_feeds.png",
              title: "看一看",
              valueWidget: Row(
                children: <Widget>[Cell.tag('NEW')],
              ),
              onPressed: () {
                print("点击了");
              },
            ),
            Cell(
              iconPath: "assets/images/ic_quick_search.png",
              title: "搜一搜",
              onPressed: () {
                print("点击了");
              },
            ),
            SizedBox(height: SEPARATE_SIZE),
            Cell(
              iconPath: "assets/images/ic_people_nearby.png",
              title: "附近的人",
              onPressed: () {
                print("点击了");
              },
            ),
            SizedBox(height: SEPARATE_SIZE),
            Cell(
              iconPath: "assets/images/ic_game_entry.png",
              title: "游戏",
              onPressed: () {
                print("点击了");
              },
              valueWidget: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Cell.descText('注册领时装抢红包'),
                  SizedBox(width: 6.0),
                  Cell.iconTag('assets/images/ad_game_notify.png',
                      showDot: true),
                  SizedBox(width: 12.0),
                ],
              ),
            ),
            SizedBox(height: SEPARATE_SIZE),
            Cell(
              iconPath: "assets/images/ic_mini_program.png",
              title: "小程序",
              onPressed: () {
                print("点击了");
              },
            ),
          ],
        ),
      ),
    );
  }
}
