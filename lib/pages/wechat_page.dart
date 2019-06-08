import 'package:flutter/material.dart';

class WeChatPage extends StatelessWidget {
  static const String routeName = "/WeChat";

  _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        // 在每一列之前，添加一个1像素高的分隔线widget
        if (index.isOdd) return Divider();
        return _buildListTile("占位 $index");
      },
    );
  }

  _buildListTile(String title) {
    return ListTile(
      title: Text(title),
      leading: FlutterLogo(size: 72.0),
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
