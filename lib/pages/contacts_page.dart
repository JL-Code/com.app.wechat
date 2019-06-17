import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/contact_viewmodel.dart'
    show ContactViewModel, ContactItemGroup, ContactItem;
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
  String _currentLetter = "";
  List<ContactItemGroup> _contacts;
  ScrollController _scrollController;
  final List<Widget> _children = [];
  final Map _letterPosMap = {INDEX_BAR_WORDS[0]: 0.0};

  @override
  void initState() {
    super.initState();
    var data = ContactViewModel.build();
    _contacts = data;
    print("initState");

    /// TODO: 数据与视图需分开
    var _pos = 0.0;
    for (var group in _contacts) {
      /// 显示分组标题
      if (group.visible) {
        _letterPosMap[group.groupName] = _pos;
        _pos += ContactItemGroup.height();
        _children.add(Row(
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
                height: Constants.ContactItemGroupHeight,
                padding: EdgeInsets.symmetric(
                    horizontal: Constants.ContactItemGroupPadding, vertical: 8),
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
        _pos += ContactItem.height();
        _children.add(Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: Constants.ContactItemPadding,
                right: Constants.ContactItemPadding,
                top: 4,
                bottom: 4,
              ),
              child: _buildAvatar(item),
            ),
            Expanded(
              child: Container(
                height: ContactItem.height(),
                alignment: Alignment.centerLeft,
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
    print("map:$_letterPosMap");
    _scrollController = new ScrollController();
    // 计算用于 IndexBar 进行定位的关键通讯录列表项的位置
    // 监听滚动事件
    _scrollController.addListener(() {
      // print("offset: $_scrollController.offset");
    });
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

  /// 得到选中的字母
  /// TODO:选中的字母需要突出显示
  String _getLetter(BuildContext context, double tileHeight, Offset globalPos) {
    RenderBox _box = context.findRenderObject();
    // 全局坐标转Widget内的坐标
    var local = _box.globalToLocal(globalPos);
    print("_getLetter $local");
    var _word = "";
    // ~/ 除法但结果取整（不进行四舍五入计算，直接舍去小数位）
    int index = (local.dy ~/ tileHeight);
    if (index > 0 && index < INDEX_BAR_WORDS.length - 1) {
      _word = INDEX_BAR_WORDS[index];
    }
    return _word;
  }

  void _getSize(GlobalKey key) {
    /// https://api.flutter.dev/flutter/widgets/GlobalKey/currentContext.html
    /// currentContext:构建具有此密钥的窗口小部件的构建上下文。 如果树中没有与此全局键匹配的窗口小部件，则当前上下文为null。
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final size = renderBox.size;
    print("SIZE of Box: $size");
  }

  Offset _getPosition(GlobalKey key) {
    final RenderBox renderBox = key.currentContext.findRenderObject();

    /// 局部坐标转全局坐标
    final Offset pos = renderBox.localToGlobal(Offset.zero);
    print("Position of Box: $pos");
    return pos;
  }

  void _jumpToIndex(String letter) {
    if (_letterPosMap.isNotEmpty) {
      print("letter : $letter");
      final _pos = _letterPosMap[letter];
      if (_pos != null) {
//        _scrollController.animateTo(_pos,
//            curve: Curves.easeOut, duration: Duration(milliseconds: 10));
        _scrollController.jumpTo(_pos);
      }
    }
  }

  /// 生成索引栏
  Widget _buildIndexBar(BuildContext context, BoxConstraints constraints) {
    final List<Widget> _letters = INDEX_BAR_WORDS.map((String word) {
//      return Container(
//        padding: EdgeInsets.symmetric(vertical: 1),
//        child: Text(
//          word,
//          style: TextStyle(fontSize: 12),
//        ),
//      );
      return Expanded(
        child: Text(
          word,
          style: TextStyle(fontSize: 12),
        ),
      );
    }).toList();

    final double _totalHeight = constraints.biggest.height;
    final double _tileHeight = _totalHeight / _letters.length;
    print("_totalHeight:$_totalHeight");

    /// GestureDetector 手势识别器
    /// see:https://api.flutter.dev/flutter/widgets/GestureDetector-class.html
    return GestureDetector(
      /// 指针已接触屏幕，可能会开始垂直移动。
      onVerticalDragDown: (DragDownDetails details) {
        print("onVerticalDragDown");
//        print("指针与屏幕接触的全局位置: ${details.globalPosition}");
        setState(() {
          this._indexBarBg = Colors.black26;
          this._currentLetter =
              _getLetter(context, _tileHeight, details.globalPosition);
          _jumpToIndex(this._currentLetter);
        });
      },

      /// 先���与屏幕接触并垂直移动的指针不再与屏幕接触，并且在停止接触屏幕时以特定速度移动
      onVerticalDragEnd: (DragEndDetails details) {
        print("onVerticalDragEnd");

        setState(() {
          this._indexBarBg = Colors.transparent;
          this._currentLetter = "";
        });
      },

      /// 先前触发onVerticalDragDown的指针未完成。
      onVerticalDragCancel: () {
        print("onVerticalDragCancel");
        setState(() {
          this._indexBarBg = Colors.transparent;
          this._currentLetter = "";
        });
      },

      /// 指针与屏幕接触并已沿垂直方向移动
      onVerticalDragUpdate: (DragUpdateDetails details) {
        print("onVerticalDragUpdate");
//        print(details.globalPosition);
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
      ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _children[index];
        },
        itemCount: _children.length,
        controller: _scrollController,
      ),
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
    // 动态添加提示
    if (this._currentLetter.isNotEmpty) {
      _body.add(
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            color: Colors.black26,
            child: Text(
              this._currentLetter,
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }
    return Stack(
      children: _body,
    );
  }
}
