import 'package:flutter/material.dart';

class MaillistPage extends StatelessWidget {
  static const String routeName = "/maillist";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Maillist"),
      ),
      body: Text("MailList"),
    );
  }
}
