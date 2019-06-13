import 'package:com_app_wechat/constants.dart';
import 'package:com_app_wechat/models/conversation.dart';
import 'package:com_app_wechat/constants.dart' show Constants;
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = "/WeChat";

  Widget _buildListView() {
    return ListView.separated(
      itemCount: mockConversationData.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          //TODO: Device值依赖后台传递。
          return _buildDeviceItem(Device.MAC);
        }
        return _buildListTile(mockConversationData[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(height: 1.0);
      },
    );
  }

  Widget _buildDeviceItem(Device device) {
    /// 图标名称
    int iconName = device == Device.MAC ? 0xe61c : 0xe6b3;

    ///系统名称
    String deviceName = device == Device.MAC ? "Mac" : "Windows";

    return Container(
      padding:
          EdgeInsets.only(left: 24.0, top: 10.0, right: 24.0, bottom: 10.0),
      color: Color(AppColors.DeviceInfoItemBg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            IconData(iconName, fontFamily: Constants.WeChatIconFontFamily),
            color: Colors.grey,
            size: 18,
          ),
          SizedBox(width: 24.0),
          Text(
            "$deviceName 微信已登录，手机通知关闭",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// 构建列表项
  ListTile _buildListTile(Conversation item) {
    /// 徽章
    //TODO: 勿扰图标和徽章 按需显示
    Widget badge = Container(
      padding: EdgeInsets.only(left: 3, right: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.redAccent,
      ),
      child: Text(
        item.unreadMsgCount.toString(),
        style: TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    Widget _avatar;
    if (item.isAvatarFromNet()) {
      // 使用 FadeInImage 来占位待网络图片加载好了替换。
      _avatar = FadeInImage.assetNetwork(
        placeholder: "assets/images/default_nor_avatar.png",
        image: item.avatar,
        height: Constants.ContactAvatarSize,
        width: Constants.ContactAvatarSize,
        fit: BoxFit.fill,
      );
    } else {
      _avatar = Image.asset(
        item.avatar,
        height: Constants.ContactAvatarSize,
        width: Constants.ContactAvatarSize,
        fit: BoxFit.fill,
      );
    }

    /// 头像
    Widget avatar = ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: _avatar,
    );

    ///头像组合容器
    Widget avatarContainer = Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        avatar,
        Positioned(
          right: -5,
          top: -5,
          child: badge,
        ),
      ],
    );

    return ListTile(
      title: Text(item.title),
      leading: avatarContainer,
      isThreeLine: false,
      subtitle: Text(
        item.desc,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12.0,
        ),
      ),
      trailing: Column(
        children: <Widget>[
          Text(
            item.updateAt,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 10),
          Icon(Icons.notifications_off, size: 14.0, color: Colors.grey),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildListView(),
    );
  }
}
