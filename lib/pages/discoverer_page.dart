import 'package:flutter/material.dart';

class DiscovererPage extends StatelessWidget {
  static const String routeName = "/discoverer";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Discoverer"),
      ),
      body: Text("Discoverer"),
    );
  }
}
