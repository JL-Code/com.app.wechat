import 'package:flutter/material.dart';

class AvatarHelper {
  /// 头像是否来自网络
  static bool isAvatarFromNet(String avatar) {
    if (avatar.indexOf('http') == 0 || avatar.indexOf('https') == 0) {
      return true;
    }
    return false;
  }

  /// 创建一个头像Avatar
  /// [avatar] 头像地址（本地地址或网络地址）
  /// [height] 头像高度
  /// [width] 头像宽度
  /// [badge] 徽章数目 默认为 0 此时不显示徽章。
  /// TODO: 后续考虑优化徽章显示。数目超过99时如何显示。
  static Widget buildAvatar(String avatar, double height, double width,
      {badge: 0}) {
    Widget _avatar;
    Widget _badgeWidget;
    if (isAvatarFromNet(avatar)) {
      // 使用 FadeInImage 来占位待网络图片加载好了替换。
      _avatar = FadeInImage.assetNetwork(
        placeholder: "assets/images/default_nor_avatar.png",
        image: avatar,
        height: height,
        width: width,
        fit: BoxFit.fill,
      );
    } else {
      _avatar = Image.asset(
        avatar,
        height: height,
        width: width,
        fit: BoxFit.fill,
      );
    }
    _avatar = ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: _avatar,
    );

    /// 显示徽章
    if (badge > 0) {
      _badgeWidget = Positioned(
        right: -5,
        top: -5,
        child: Container(
          padding: EdgeInsets.only(left: 3, right: 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.redAccent,
          ),
          child: Text(
            badge.toString(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      return Stack(
        overflow: Overflow.visible,
        children: <Widget>[_avatar, _badgeWidget],
      );
    }
    return _avatar;
  }
}
