import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class LayoutSelect extends StatelessWidget {
  final TextEditingController ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Layout"),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/ping_test');
                      },
                      child: Text('Ping Test'),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/wasd_layout');
                      },
                      child: Text('WASD Layout'),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
