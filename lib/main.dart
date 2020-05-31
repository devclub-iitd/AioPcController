
import 'package:flutter/material.dart';
import 'LayoutSelect.dart';
import 'HomeScreen.dart';
import 'WasdLayout.dart';
import 'PingTest.dart';
import 'tilt.dart';
import 'Custom.dart';
import 'LoadCustom.dart';
import 'CustomLayout.dart';
void main() async {
  // modify with your true address/port
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/layout_select': (context) => LayoutSelect(),
        '/ping_test': (context) => PingTest(),
        '/wasd_layout': (context) => WasdLayout(),
        '/gyro':(context) => Gyro(),
        '/custom':(context) => Custom(),
        '/loadcustom':(context) => LoadCustom(),
        '/custom_layout':(context) => CustomLayout(),
      },
    );
  }
}

