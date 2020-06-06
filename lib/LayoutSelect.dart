import 'package:aio_pc_controller/Custom.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'LoadCustom.dart';
import 'tilt.dart';
import 'dart:async';
import 'package:sensors/sensors.dart';
import 'package:flutter/services.dart';
import 'globals.dart';
class LayoutSelect extends StatelessWidget {
  final TextEditingController ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(!ovisit){
      tilt();
      Timer.periodic(Duration(milliseconds: 50), (Timer t) {
        if (tiltcontrol) {
          tsend();
        }
      });
      ovisit = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Layout"),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(2.0),
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 70.0,
                    ),
                    Text(
                      'Ping Test',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20.0,
                        ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/ping_test');
                },
              )
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(2.0),
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.keyboard,
                      color: Colors.white,
                      size: 70.0,
                    ),
                    Text(
                      'WASD',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20.0,
                        ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/wasd_layout');
                },
              )
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(2.0),
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.rotate_left,
                      color: Colors.white,
                      size: 70.0,
                    ),
                    Text(
                      'Gyroscopic Control',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20.0,
                        ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/gyro');
                },
              )
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(2.0),
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.settings_remote,
                      color: Colors.white,
                      size: 70.0,
                    ),
                    Text(
                      'X-Controller',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20.0,
                        ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/controller');
                },
              )
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(2.0),
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.create,
                      color: Colors.white,
                      size: 70.0,
                    ),
                    Text(
                      'Create Custom Layout',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 18.0,
                        ),
                    )
                  ],
                ),
                onTap: () {
                  customLoader(context, '_untitled');
                },
              )
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(2.0),
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.save_alt,
                      color: Colors.white,
                      size: 70.0,
                    ),
                    Text(
                      'My Custom Layouts',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20.0,
                        ),
                    )
                  ],
                ),
                onTap: () {
                  loadCustomBuilder(context);
                },
              )
            ),
          ],
        ));
  }
}
