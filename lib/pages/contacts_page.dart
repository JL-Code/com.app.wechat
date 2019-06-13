import 'package:com_app_wechat/models/contact_viewmodel.dart';
import 'package:flutter/material.dart';
import '../models/contact_viewmodel.dart' show ContactViewModel;
import 'package:com_app_wechat/constants.dart' show Constants, AppColors;

const INDEX_BAR_WORDS = [
  "↑",
  "☆",
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

class ContactsPage extends StatefulWidget {
  static const String routeName = "/contacts";
  ContactsPage({Key key}) : super(key: key);

  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Color _indexBarBg = Colors.transparent;
  String _currentLetter = '';
  List<ContactItemGroup> _contacts;
  ScrollController _scrollController;
  final Map _letterPosMap = {INDEX_BAR_WORDS[0]: 0.0};

  @override
  void initState() {
    super.initState();
    _contacts = ContactViewModel.build();
    _scrollController = new ScrollController();
    // 计算用于 IndexBar 进行定位的关键通讯录列表项的位置
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// 构建头像
  Widget _buildAvatar(ContactItem item) {
    Widget _avatar;
    if (item.isAvatarFromNet) {
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: _avatar,
    );
  }

  _buildListView(List<ContactItemGroup> contactGroup) {
    var children = <Widget>[];
    for (var group in contactGroup) {
      if (group.visible) {
        children.add(Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(AppColors.ContactGroupTitleBg),
                  border: Border(
                    bottom: BorderSide(
                      width: Constants.DividerWidth,
                      color: const Color(AppColors.DividerColor),
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Text(
                  group.groupName,
                  style: TextStyle(
                    color: const Color(AppColors.ContactGroupTitleText),
                  ),
                ),
              ),
            )
          ],
        ));
      }
      for (var item in group.items) {
        children.add(Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
              child: _buildAvatar(item),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: Constants.DividerWidth,
                      color: const Color(AppColors.DividerColor),
                    ),
                  ),
                ),
                child: Text(item.title),
              ),
            )
          ],
        ));
      }
    }
    return ListView(
      children: children,
    );
  }

  String _getLetter(BuildContext context, double tileHeight, Offset globalPos) {
    RenderBox _box = context.findRenderObject();
    var local = _box.globalToLocal(globalPos);
    int index = (local.dy ~/ tileHeight).clamp(0, INDEX_BAR_WORDS.length - 1);
    return INDEX_BAR_WORDS[index];
  }

  void _jumpToIndex(String letter) {
    if (_letterPosMap.isNotEmpty) {
      final _pos = _letterPosMap[letter];
      if (_pos != null) {
        _scrollController.animateTo(_pos,
            curve: Curves.easeOut, duration: Duration(milliseconds: 200));
      }
    }
  }

  /// 生成索引栏
  Widget _buildIndexBar(BuildContext context, BoxConstraints constraints) {
    final List<Widget> _letters = INDEX_BAR_WORDS.map((String word) {
      // return Expanded(
      //   child: Text(
      //     word,
      //     style: TextStyle(fontSize: 11),
      //   ),
      // );
      return Container(
        padding: EdgeInsets.symmetric(vertical: 1),
        child: Text(
          word,
          style: TextStyle(fontSize: 11),
        ),
      );
    }).toList();

    final double _totalHeight = constraints.biggest.height;
    final double _tileHeight = _totalHeight / _letters.length;
    return GestureDetector(
      onVerticalDragDown: (DragDownDetails details) {
        setState(() {
          this._indexBarBg = Colors.black26;
          this._currentLetter =
              _getLetter(context, _tileHeight, details.globalPosition);
          _jumpToIndex(this._currentLetter);
        });
      },
      onVerticalDragEnd: (DragEndDetails details) {
        setState(() {
          this._indexBarBg = Colors.transparent;
          this._currentLetter = null;
        });
      },
      onVerticalDragCancel: () {
        setState(() {
          this._indexBarBg = Colors.transparent;
          this._currentLetter = null;
        });
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          this._indexBarBg = Colors.black26;
          this._currentLetter =
              _getLetter(context, _tileHeight, details.globalPosition);
          _jumpToIndex(this._currentLetter);
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _letters,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _body = [
      _buildListView(_contacts),
      Positioned(
        width: Constants.IndexBarWidth,
        right: 0.0,
        top: 0.0,
        bottom: 0.0,
        child: Container(
          color: _indexBarBg,
          child: LayoutBuilder(
            builder: _buildIndexBar,
          ),
        ),
      )
    ];
    return Stack(
      children: _body,
    );
  }
}
