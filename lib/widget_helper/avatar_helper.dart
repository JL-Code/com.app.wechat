import 'package:flutter/material.dart';

class AvatarHelper {
  /// 头像是否来自网络
  static bool isAvatarFromNet(String avatar) {
    if (avatar.indexOf('http') == 0 || avatar.indexOf('https') == 0) {
      return true;
    }
    return false;
  }

  /// 构建头像
  static Widget buildAvatar(String avatar, double height, double width) {
    Widget _avatar;
    if (isAvatarFromNet(avatar)) {
      // 使用 FadeInImage 来占位待网络图片加载好了替换。
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _avatar = FadeInImage.assetNetwork(
            placeholder: "assets/images/default_nor_avatar.png",
            image: avatar,
            height: height,
            width: width,
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
      _avatar = Image.asset(
        avatar,
        height: height,
        width: width,
        fit: BoxFit.fill,
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: _avatar,
    );
  }
}
