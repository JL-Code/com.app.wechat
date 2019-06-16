import 'package:com_app_wechat/constants.dart';
import 'package:com_app_wechat/widgets/cell.dart';
import 'package:com_app_wechat/widget_helper/avatar_helper.dart';
import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  static const String routeName = "/user";
  static const DIVIDER_SEPARATOR_SIZE = 8.0;
  static const RADIUS = 6.0;
  static const SEPARATOR_SIZE = 16.0;
  static const AVATAR_SIZE = 58.0;
  static const QR_CODE_PREV_SIZE = 18.0;

  Widget _buildHead() {
    return FlatButton(
      padding: EdgeInsets.only(bottom: 45, left: 20),
      onPressed: () {
        print("点击了头部");
      },
      color: AppColors.HeaderCardBg,
      child: Row(
        children: <Widget>[
          AvatarHelper.buildAvatar(
              "https://randomuser.me/api/portraits/women/57.jpg",
              AVATAR_SIZE,
              AVATAR_SIZE),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.only(left: SEPARATOR_SIZE, bottom: 5.0),
                  child: Text("拖走", style: AppStyles.HeaderCardTitleTextStyle),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: SEPARATOR_SIZE),
                        child: Text(
                          "微信号：me-code",
                          style: AppStyles.HeaderCardDesTextStyle,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/ic_qrcode_preview_tiny.png',
                      width: QR_CODE_PREV_SIZE,
                      height: QR_CODE_PREV_SIZE,
                    ),
                    Cell.buildRightArrow()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildHead(),
        SizedBox(
          height: DIVIDER_SEPARATOR_SIZE,
        ),
        Cell(
          iconPath: "assets/images/ic_wallet.png",
          title: "支付",
          onPressed: () {
            print("点击了支付");
          },
        ),
        SizedBox(height: DIVIDER_SEPARATOR_SIZE),
        Cell(
          iconPath: "assets/images/ic_collections.png",
          title: "收藏",
          onPressed: () {
            print("点击了支付");
          },
        ),
        Cell(
          iconPath: "assets/images/ic_album.png",
          title: "相册",
          onPressed: () {
            print("点击了支付");
          },
        ),
        Cell(
          iconPath: "assets/images/ic_cards_wallet.png",
          title: "卡包",
          onPressed: () {
            print("点击了支付");
          },
        ),
        Cell(
          iconPath: "assets/images/ic_emotions.png",
          title: "表情",
          onPressed: () {
            print("点击了支付");
          },
        ),
        SizedBox(height: DIVIDER_SEPARATOR_SIZE),
        Cell(
          iconPath: "assets/images/ic_settings.png",
          title: "设置",
          onPressed: () {
            print("点击了支付");
          },
        ),
      ],
    );
  }
}

class MeViewModel {}
