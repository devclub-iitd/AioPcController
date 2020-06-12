import 'package:aio_pc_controller/HomeScreen.dart';
import 'Theme.dart';
import 'package:flutter/material.dart';
import 'LoadCustom.dart';
import 'tilt.dart';
import 'dart:async';
import 'package:sensors/sensors.dart';
import 'package:flutter/services.dart';
import 'globals.dart';
import 'config.dart';

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
      ovisit = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Layout"),
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: currentThemeColors.tabColor,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: currentThemeColors.unselectedTabBorderColor, 
                              width: 2.0,
                            )
                          )
                        ),
                        child: Center(
                          child: Text(
                            'CONNECT',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white54,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      onTap: (){
                        Navigator.pushReplacement(context, PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => HomeScreen(channel:sock),
                          transitionDuration: Duration(seconds: 0),
                        ),);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: currentThemeColors.tabColor,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: currentThemeColors.selectedTabBorderColor, 
                              width: 2.0,
                            )
                          )
                        ),
                        child: Center(
                          child: Text(
                            'LAYOUTS',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: currentThemeColors.tabColor,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: currentThemeColors.unselectedTabBorderColor, 
                              width: 2.0,
                            )
                          )
                        ),
                        child: Center(
                          child: Text(
                            'CUSTOM',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white54,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      onTap: (){
                        loadCustomBuilder(context);
                      },
                    ),
                  ),
                ),
              ],
            ), 
            preferredSize: Size.fromHeight(48.0)
          ),
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
                      Icons.network_check,
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
              ),
              onTap: () {
                Navigator.pushNamed(context, '/ping_test');
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
