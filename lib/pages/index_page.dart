import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './me_page.dart';
import './discover_page.dart';
import './contacts_page.dart';
import './chat_page.dart';
import '../constants.dart';
import '../i18n/strings.dart' show Strings;

/// 行为选项
enum ActionItems { GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT, HELP }

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  static const HeaderColor = const Color(AppColors.PrimaryColor);
  String title = "微信";
  Color headerColor;
  List<Widget> _mainActions;
  List<Widget> _functionActions;
  int _currentIndex = 0;
  List<Widget> _pages;
  PageController _pageController;

  ///TODO: 首页数据应该被封装到ViewModel
  final items = <BottomNavigationBarItem>[
    new BottomNavigationBarItem(
      title: Text("微信"),
      icon: Icon(
        IconData(
          0xe608,
          fontFamily: Constants.WeChatIconFontFamily,
        ),
      ),
    ),
    new BottomNavigationBarItem(
      title: Text("通讯录"),
      icon: Icon(
        IconData(
          0xe601,
          fontFamily: Constants.WeChatIconFontFamily,
        ),
      ),
    ),
    new BottomNavigationBarItem(
      title: Text("发现"),
      icon: Icon(
        IconData(
          0xe600,
          fontFamily: Constants.WeChatIconFontFamily,
        ),
      ),
    ),
    new BottomNavigationBarItem(
      title: Text("我"),
      icon: Icon(
        IconData(
          0xe6c0,
          fontFamily: Constants.WeChatIconFontFamily,
        ),
      ),
    )
  ];

  /// 构建一个弹层菜单项
  Widget _buildPopupMunuItem(int iconName, String title) {
    return Row(
      children: <Widget>[
        Icon(
            IconData(
              iconName,
              fontFamily: Constants.WeChatIconFontFamily,
            ),
            size: 22.0,
            color: const Color(AppColors.AppBarPopupMenuColor)),
        Container(width: 12.0),
        Text(
          title,
          style: TextStyle(color: const Color(AppColors.AppBarPopupMenuColor)),
        ),
      ],
    );
  }

  @override
  void initState() {
    /// 初始页面相关
    _pageController = PageController(initialPage: _currentIndex);
    _pages = [
      ChatPage(),
      ContactsPage(),
      DiscoverPage(),
      MePage(),
    ];

    _mainActions = [
      IconButton(
        icon: Icon(
            IconData(
              0xe65e,
              fontFamily: Constants.WeChatIconFontFamily,
            ),
            size: Constants.ActionIconSize,
            color: const Color(AppColors.ActionIconColor)),
        onPressed: () {
          print('点击了搜索按钮');
        },
      ),
      Theme(
        data: ThemeData(cardColor: Color(AppColors.ActionMenuBgColor)),
        child: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return <PopupMenuItem<ActionItems>>[
              PopupMenuItem(
                child: _buildPopupMunuItem(0xe69e, Strings.MenuGroupChat),
                value: ActionItems.GROUP_CHAT,
              ),
              PopupMenuItem(
                child: _buildPopupMunuItem(0xe638, Strings.MenuAddFriends),
                value: ActionItems.ADD_FRIEND,
              ),
              PopupMenuItem(
                child: _buildPopupMunuItem(0xe61b, Strings.MenuQRScan),
                value: ActionItems.QR_SCAN,
              ),
              PopupMenuItem(
                child: _buildPopupMunuItem(0xe62a, Strings.MenuPayments),
                value: ActionItems.PAYMENT,
              ),
              PopupMenuItem(
                child: _buildPopupMunuItem(0xe63d, Strings.MenuHelp),
                value: ActionItems.HELP,
              ),
            ];
          },
          icon: Icon(
            IconData(
              0xe60e,
              fontFamily: Constants.WeChatIconFontFamily,
            ),
            size: Constants.ActionIconSize + 4.0,
            color: const Color(AppColors.ActionIconColor),
          ),
          onSelected: (ActionItems selected) {
            print('点击的是$selected');
          },
        ),
      ),
    ];
    _functionActions = [
      IconButton(
        icon: Icon(
            IconData(
              0xe60a,
              fontFamily: Constants.WeChatIconFontFamily,
            ),
            size: Constants.ActionIconSize + 4.0,
            color: const Color(AppColors.ActionIconColor)),
        onPressed: () {
          print('打开相机拍短视频');
        },
      ),
      Container(width: 16.0),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title, style: AppStyles.TitleStyle),
        backgroundColor: this.headerColor,
        elevation: 0.0,

        /// 应用栏亮度
        brightness: Brightness.light,
        actions: _currentIndex == 3 ? _functionActions : _mainActions,
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0:
                this.title = Strings.TitleWeChat;
                this.headerColor = HeaderColor;
                break;
              case 1:
                this.title = Strings.TitleContact;
                this.headerColor = HeaderColor;
                break;
              case 2:
                this.title = Strings.TitleDiscovery;
                this.headerColor = HeaderColor;
                break;
              case 3:
                this.title = '';
                this.headerColor = Colors.white;
                break;
            }
          });
        },
        scrollDirection: Axis.horizontal,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _currentIndex,
        selectedItemColor:
            const Color(AppColors.BottomNavigationSelectedItemColor),
        selectedFontSize: 12.0,
        backgroundColor: const Color(AppColors.BottomNavigationBarColor),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
