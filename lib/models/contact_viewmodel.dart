/*
 * @Description: 联系人视图模型
 * @Author: jiangy
 * @Date: 2019-06-13 21:06:28
 * @Version: 
 */
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../constants.dart' show Constants;

class ContactViewModel {
  static final data = new List<ContactItemGroup>();

  static List<ContactItemGroup> build() {
    // 清空数据
    data.clear();
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
      ]),
    );

    final letters = [
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z"
    ];
    final List<WordPair> words = generateWordPairs().take(300).toList();
    int _wordIndex = 0;
    for (var i = 0; i < letters.length; i++) {
      var _letter = letters[i];
      var _items = <ContactItem>[];
      var _group = ContactItemGroup(
        groupName: _letter,
        items: _items,
      );
      for (var i = 0; i < 5; i++) {
        _items.add(ContactItem(
          avatar: 'https://randomuser.me/api/portraits/women/${70 + i}.jpg',
          title: words[_wordIndex].asPascalCase,
          nameIndex: _letter,
        ));
        _wordIndex++;
      }
      data.add(_group);
    }
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

  /// 返回ContactItemGroup 高度
  static double height() {
    return Constants.ContactItemGroupHeight;
  }
}

class ContactItem {
  const ContactItem({
    @required this.title,
    @required this.avatar,
    this.nameIndex: "",
  });

  final String title;
  final String avatar;
  final String nameIndex;

  bool get isAvatarFromNet {
    return AvatarUtil.isAvatarFromNet(this.avatar);
  }

  static double height() {
    return Constants.ContactAvatarSize + Constants.ContactItemPadding / 2;
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
