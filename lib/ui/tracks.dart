import 'package:flutter/material.dart';

class Tracks extends StatelessWidget {
  final String title;
  Tracks(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
        ),
        body: new Center(
          child: Text(title),
        ));
  }
}
