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
          bottom: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: Colors.blue[700],
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white, 
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
                              fontSize: 18.0,
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
                    color: Colors.blue,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.blue, 
                              width: 2.0,
                            )
                          )
                        ),
                        child: Center(
                          child: Text(
                            'MY LAYOUTS',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white54,
                              fontSize: 18.0,
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
                color: Colors.blue[800],
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
                color: Colors.blue[800],
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
                color: Colors.blue[800],
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
                color: Colors.blue[800],
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
                color: Colors.blue[800],
                margin: const EdgeInsets.all(2.0),
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
              ),
              onTap: () {
                customLoader(context, '_untitled');
              },
            ),
            GestureDetector(
              child :Container(
                color: Colors.blue[800],
                margin: const EdgeInsets.all(2.0),
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
              ),
              onTap: () {
                loadCustomBuilder(context);
              },
            ),
          ],
        ));
  }
}
