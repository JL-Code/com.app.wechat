/*
 * @Description: 联系人视图模型
 * @Author: jiangy
 * @Date: 2019-06-13 21:06:28
 * @Version: 
 */
import 'package:flutter/material.dart';

class ContactViewModel {
  // var contactMap = new Map<String, List<ContactItem>>();
  // var indexList = ["A", "B", "C", "D"];
  static final data = new List<ContactItemGroup>();

  static List<ContactItemGroup> build() {
    // action
    data.add(
        const ContactItemGroup(groupName: "actions", visible: false, items: [
      const ContactItem(
        title: "新的朋友",
        avatar: "assets/images/ic_new_friend.png",
      ),
      const ContactItem(
        title: "群聊",
        avatar: "assets/images/ic_group_chat.png",
      ),
      const ContactItem(
        title: "标签",
        avatar: "assets/images/ic_tag.png",
      ),
      const ContactItem(
        title: "公众号",
        avatar: "assets/images/ic_public_account.png",
      ),
    ]));

    // 我的企业
    data.add(const ContactItemGroup(
      groupName: "enterprise",
      items: [],
      visible: false,
    ));

    // 联系人
    data.add(const ContactItemGroup(
      groupName: "contacts",
      items: [
        const ContactItem(
          avatar: 'assets/images/ic_file_transfer.png',
          title: '文件传输助手',
        ),
        const ContactItem(
          avatar: 'assets/images/ic_tx_news.png',
          title: '腾讯新闻',
        ),
        const ContactItem(
          avatar: 'assets/images/ic_wx_games.png',
          title: '微信游戏',
        ),
        const ContactItem(
          avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
          title: '汤姆丁',
        ),
        const ContactItem(
          avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
          title: 'Tina Morgan',
        ),
        const ContactItem(
          avatar: 'assets/images/ic_fengchao.png',
          title: '蜂巢智能柜',
        ),
        const ContactItem(
          avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
          title: 'Lily',
        ),
        const ContactItem(
          avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
          title: '汤姆丁',
        ),
        const ContactItem(
          avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
          title: 'Tina Morgan',
        ),
        const ContactItem(
          avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
          title: 'Lily',
        ),
        const ContactItem(
          avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
          title: '汤姆丁',
        ),
        const ContactItem(
          avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
          title: 'Tina Morgan',
        ),
        const ContactItem(
          avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
          title: 'Lily',
        )
      ],
    ));

    return data;
  }
}

class ContactItemGroup {
  const ContactItemGroup({
    this.groupName: "",
    @required this.items,
    this.visible: true,
  });
  final String groupName;
  final List<ContactItem> items;
  final bool visible;
}

class ContactItem {
  const ContactItem({
    @required this.title,
    @required this.avatar,
  });

  final String title;
  final String avatar;
  bool get isAvatarFromNet {
    return AvatarUtil.isAvatarFromNet(this.avatar);
  }
}

class AvatarUtil {
  /// 头像是否来自网络
  static bool isAvatarFromNet(String avatar) {
    if (avatar.indexOf('http') == 0 || avatar.indexOf('https') == 0) {
      return true;
    }
    return false;
  }
}
