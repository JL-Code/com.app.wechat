/*
 * @Description: 会话模型
 * @Author: jiangy
 * @Date: 2019-06-08 22:30:39
 */

import 'package:flutter/foundation.dart';

const List<Conversation> mockConversationData = [
  const Conversation(avatar: "", title: "", updateAt: ""),
  const Conversation(
      avatar: 'assets/images/ic_file_transfer.png',
      title: '文件传输助手',
      desc: '',
      updateAt: '19:56',
      unreadMsgCount: 2,
      displayDot: true),
  const Conversation(
    avatar: 'assets/images/ic_tx_news.png',
    title: '腾讯新闻',
    desc: '豪车与出租车刮擦 俩车主划拳定责',
    updateAt: '17:20',
  ),
  const Conversation(
    avatar: 'assets/images/ic_wx_games.png',
    title: '微信游戏',
    titleColor: 0xff586b95,
    desc: '25元现金助力开学季！',
    updateAt: '17:12',
  ),
  const Conversation(
    avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
    title: '汤姆丁',
    desc: '今晚要一起去吃肯德基吗？',
    updateAt: '17:56',
    isMute: true,
    unreadMsgCount: 0,
  ),
  const Conversation(
    avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
    title: 'Tina Morgan',
    desc: '晚自习是什么来着？你知道吗，看到的话赶紧回复我',
    updateAt: '17:58',
    isMute: false,
    unreadMsgCount: 3,
  ),
  const Conversation(
    avatar: 'assets/images/ic_fengchao.png',
    title: '蜂巢智能柜',
    titleColor: 0xff586b95,
    desc: '喷一喷，竟比洗牙还神奇！5秒钟还你一个漂亮洁白的口腔。',
    updateAt: '17:12',
  ),
  const Conversation(
    avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
    title: 'Lily',
    desc: '今天要去运动场锻炼吗？',
    updateAt: '昨天',
    isMute: false,
    unreadMsgCount: 99,
  ),
  const Conversation(
    avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
    title: '汤姆丁',
    desc: '今晚要一起去吃肯德基吗？',
    updateAt: '17:56',
    isMute: true,
    unreadMsgCount: 0,
  ),
  const Conversation(
    avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
    title: 'Tina Morgan',
    desc: '晚自习是什么来着？你知道吗，看到的话赶紧回复我',
    updateAt: '17:58',
    isMute: false,
    unreadMsgCount: 3,
  ),
  const Conversation(
    avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
    title: 'Lily',
    desc: '今天要去运动场锻炼吗？',
    updateAt: '昨天',
    isMute: false,
    unreadMsgCount: 0,
  ),
  const Conversation(
    avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
    title: '汤姆丁',
    desc: '今晚要一起去吃肯德基吗？',
    updateAt: '17:56',
    isMute: true,
    unreadMsgCount: 0,
  ),
  const Conversation(
    avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
    title: 'Tina Morgan',
    desc: '晚自习是什么来着？你知道吗，看到的话赶紧回复我',
    updateAt: '17:58',
    isMute: false,
    unreadMsgCount: 1,
  ),
  const Conversation(
    avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
    title: 'Lily',
    desc: '今天要去运动场锻炼吗？',
    updateAt: '昨天',
    isMute: false,
    unreadMsgCount: 0,
  ),
];

enum Device { MAC, WIN }

class Conversation {
  const Conversation({
    this.avatar,
    @required this.title,
    @required this.updateAt,
    this.titleColor,
    this.isMute: false,
    this.desc,
    this.displayDot: false,
    this.unreadMsgCount: 0,
  })  : assert(updateAt != null),
        assert(title != null);

  final String avatar;
  final String title;
  final int titleColor;
  final String desc;
  final String updateAt;
  // 是否开启静默
  final bool isMute;
  final int unreadMsgCount;
  final bool displayDot;

  /// 头像是否来自网络
  bool isAvatarFromNet() {
    if (this.avatar.indexOf('http') == 0 || this.avatar.indexOf('https') == 0) {
      return true;
    }
    return false;
  }
}

class ConversationPageData {
  const ConversationPageData({
    this.device,
    this.conversations,
  });

  final Device device;
  final List<Conversation> conversations;

  static List<Conversation> mock() {
    return mockConversationData;
  }
}
