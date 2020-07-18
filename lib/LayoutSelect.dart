import 'package:flutter_icons/flutter_icons.dart';

import 'Theme.dart';
import 'package:flutter/material.dart';
import 'LoadCustom.dart';
import 'Tilt.dart';
import 'dart:async';
import 'globals.dart';
import 'config.dart';
import 'Tabs.dart';

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
          bottom: PreferredSize(child: Tabs('LAYOUTS'), preferredSize: Size.fromHeight(48.0)),
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
                      MaterialCommunityIcons.steering,
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
                      Ionicons.logo_game_controller_b,
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
                      MaterialCommunityIcons.trackpad,
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
