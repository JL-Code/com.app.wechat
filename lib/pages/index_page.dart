import 'package:flutter/material.dart';
import './user_page.dart';
import './discoverer_page.dart';
import './maillist_page.dart';
import './wechat_page.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  /// 当前选中index
  int currentIndex = 0;
  Widget currentPage;

  final List pages = [
    WeChatPage(),
    MaillistPage(),
    DiscovererPage(),
    UserPage(),
  ];

  @override
  void initState() {
    currentPage = pages[currentIndex];
    super.initState();
  }

  final items = <BottomNavigationBarItem>[
    new BottomNavigationBarItem(
      title: Text("微信"),
      icon: Icon(Icons.access_time),
    ),
    new BottomNavigationBarItem(
      title: Text("通讯录"),
      icon: Icon(Icons.mail),
    ),
    new BottomNavigationBarItem(
      title: Text("发现"),
      icon: Icon(Icons.search),
    ),
    new BottomNavigationBarItem(
      title: Text("我"),
      icon: Icon(Icons.person_outline),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        selectedFontSize: 12.0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          print("onTap index: $index");
          setState(() {
            currentIndex = index;
            currentPage = pages[index];
          });
        },
      ),
    );
  }
}
