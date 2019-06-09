import 'package:com_app_wechat/models/conversation.dart';
import 'package:flutter/material.dart';

class WeChatPage extends StatelessWidget {
  static const String routeName = "/WeChat";

  _buildListView() {
    return ListView.separated(
      padding: EdgeInsets.all(16.0),
      itemCount: mockConversationData.length,
      itemBuilder: (BuildContext context, int index) {
        // 在每一列之前，添加一个1像素高的分隔线widget
        return _buildListTile(mockConversationData[index]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  /// 构建列表项
  ListTile _buildListTile(Conversation item) {
    /// 徽章
    Widget badge = Container(
      padding: EdgeInsets.only(left: 3, right: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.red,
      ),
      child: Text(
        item.unreadMsgCount.toString(),
        style: TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );

    Widget _avatar;
    if (item.isAvatarFromNet()) {
      _avatar = Image.network(
        item.avatar,
        height: 40,
        width: 40,
        fit: BoxFit.fill,
      );
    } else {
      _avatar = Image.asset(
        item.avatar,
        height: 40,
        width: 40,
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

      /// 头像
      leading: avatarContainer,
      subtitle: Text(
        item.desc,
        style: TextStyle(fontSize: 12.0),
      ),
      isThreeLine: false,
      trailing: Column(
        children: <Widget>[
          Text(
            item.updateAt,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 10),
          Icon(
            Icons.notifications_off,
            size: 18.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("微信"),
        actions: <Widget>[
          new Icon(Icons.search),
          new Icon(Icons.add_circle_outline)
        ],
      ),
      body: _buildListView(),
    );
  }
}
