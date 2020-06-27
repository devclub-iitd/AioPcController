import 'package:aio_pc_controller/HomeScreen.dart';
import 'Theme.dart';
import 'package:flutter/material.dart';
import 'LoadCustom.dart';
import 'Tilt.dart';
import 'dart:async';
import 'package:sensors/sensors.dart';
import 'package:flutter/services.dart';
import 'globals.dart';
import 'config.dart';
import 'Tabs.dart';
import 'config.dart';
import 'dart:math';
import 'dart:io';

class LayoutSelect extends StatelessWidget {
  final TextEditingController ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!ovisit) {
      tilt();
      Timer.periodic(Duration(milliseconds: 50), (Timer t) {
        if (tiltcontrol) {
          tsend();
        }
      });
      Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
        statusCheck();
      });
      ovisit = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Layout"),
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
              child: Tabs('LAYOUTS'), preferredSize: Size.fromHeight(48.0)),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              child: Container(
                color: currentThemeColors.gridButtonColor,
                margin: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.directions_car,
                      color: Colors.white,
                      size: 70.0,
                    ),
                    Text(
                      'Racing Keyboard',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/wasd_layout');
              },
            ),
            GestureDetector(
              child: Container(
                color: currentThemeColors.gridButtonColor,
                margin: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.directions_car,
                      color: Colors.white,
                      size: 70.0,
                    ),
                    Text(
                      'Racing Keyboard 1',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/racing_layout');
              },
            ),
            GestureDetector(
              child: Container(
                color: currentThemeColors.gridButtonColor,
                margin: const EdgeInsets.all(2.0),
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
              ),
              onTap: () {
                Navigator.pushNamed(context, '/gyro');
              },
            ),
            GestureDetector(
              child: Container(
                color: currentThemeColors.gridButtonColor,
                margin: const EdgeInsets.all(2.0),
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
              ),
              onTap: () {
                Navigator.pushNamed(context, '/controller');
              },
            ),
            GestureDetector(
              child: Container(
                color: currentThemeColors.gridButtonColor,
                margin: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.mouse,
                      color: Colors.white,
                      size: 70.0,
                    ),
                    Text(
                      'Trackpad',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/trackpad');
              },
            ),
          ],
        ));
  }
}
