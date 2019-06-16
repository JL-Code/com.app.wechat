import 'package:com_app_wechat/constants.dart';
import 'package:com_app_wechat/models/choice.dart';
import 'package:com_app_wechat/models/conversation.dart';
import 'package:com_app_wechat/constants.dart' show Constants;
import 'package:com_app_wechat/widget_helper/avatar_helper.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = "/WeChat";

  Widget _buildListView() {
    return ListView.builder(
      itemCount: mockConversationData.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          //TODO: Device值依赖后台传递。
          return _buildDeviceItem(Device.MAC);
        }
        return _ChatCellItem(conversation: mockConversationData[index]);
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildListView(),
    );
  }
}

class _ChatCellItem extends StatelessWidget {
  _ChatCellItem({Key key, this.conversation, this.tapPos})
      : assert(conversation != null),
        super(key: key);

  final Conversation conversation;

  /// 点击位置
  Offset tapPos;

  static const VERTICAL_PADDING = 12.0;
  static const HORIZONTAL_PADDING = 18.0;

  /// 显示上下文菜单
  void _showMenu(BuildContext context, Offset tapPos) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromLTRB(tapPos.dx, tapPos.dy,
        overlay.size.width - tapPos.dx, overlay.size.height - tapPos.dy);

    final _defaultChatChoices = <Choice>[
      Choice(title: "标记未读"),
      Choice(title: "置顶聊天"),
      Choice(title: "删除该聊天")
    ];
    final _items = _defaultChatChoices.map((Choice choice) {
      return new PopupMenuItem<Choice>(
        value: choice,
        child: new Text(choice.title),
      );
    }).toList();

    showMenu<Choice>(context: context, position: position, items: _items)
        .then((Choice selected) {
      print("selected:$selected");
    });
  }

  @override
  Widget build(BuildContext context) {
    final conversation = this.conversation;
    final _footerWidgets = <Widget>[
      Text(
        conversation.updateAt,
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
      SizedBox(height: 10),
    ];
    if (conversation.isMute) {
      _footerWidgets
          .add(Icon(Icons.notifications_off, size: 14.0, color: Colors.grey));
    }
    return Material(
      color: Color(AppColors.ConversationItemBg),
      child: InkWell(
          onTap: () {},
          onTapDown: (TapDownDetails details) {
            tapPos = details.globalPosition;
          },
          onLongPress: () {
            _showMenu(context, tapPos);
          },
          child: Container(
            padding: EdgeInsets.only(left: HORIZONTAL_PADDING),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AvatarHelper.buildAvatar(
                    conversation.avatar,
                    Constants.ConversationAvatarSize,
                    Constants.ConversationAvatarSize,
                    badge: conversation.unreadMsgCount),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 12,
                        top: VERTICAL_PADDING,
                        right: HORIZONTAL_PADDING,
                        bottom: VERTICAL_PADDING),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                          width: Constants.DividerWidth,
                          color: Color(AppColors.DividerColor)),
                    )),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                conversation.title,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                conversation.desc,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: _footerWidgets,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
