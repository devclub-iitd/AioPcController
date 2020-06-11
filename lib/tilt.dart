import 'globals.dart';
import 'package:flutter/material.dart';
import 'config.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'Theme.dart';

void tilt() {
  final subscription = accelerometerEvents.listen((AccelerometerEvent event) {
    gcurr = event.y * (event.x<0?-1:1);
  });
}
void _send(char) {
  print("Sending " + char);
  sock.write('button' + '&' + char + '%');
}

void tsend() {
  if (gcurr > 0.6) {
    String s = ( min(gcurr / 8, 1)).toString();
    sock.write("tilt&-&" + s + '%');
  } else if (gcurr < -0.6) {
    String s = ( min((-1 * gcurr) / 8, 1)).toString();
    sock.write("tilt&+&" + s + '%');
  } else {
    sock.write("tilt&+&" + '0' + '%');
  }
}

class Gyro extends StatefulWidget {
  @override
  _GyroState createState() => _GyroState();
}

class _GyroState extends State<Gyro> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if(tiltcontrol){
      sock.write("tilt&0%");
      tiltcontrol = false;
    }
    super.dispose();
  }

  int updark = 0, downdark = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Tilt to Control"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  tiltcontrol = !tiltcontrol;
                });
                if (!tiltcontrol) sock.write("tilt&0%");
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Tilting mode has been turned ' +
                        (tiltcontrol ? 'ON' : 'OFF')),
                    duration: Duration(milliseconds: 400)));
              },
              icon: Icon(Icons.rotate_left,
                  color: tiltcontrol ? Colors.green : Colors.red),
            )
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: GestureDetector(
                      onPanStart: (details) {
                        setState((){downdark = 1;});
                        _send('down&s');
                      },
                      onPanEnd: (details) {
                        setState((){downdark = 0;});
                        _send('up&s');
                      },
                      child: Container(
                        color: currentThemeColors.buttonColor[downdark],
                        padding: const EdgeInsets.all(80.0),
                        child: Icon(
                          Icons.arrow_downward,
                          color: currentThemeColors.buttonTextColor,
                          size: 45.0,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onPanStart: (_) {
                        setState((){updark = 1;});
                        _send('down&w');
                      },
                      onPanEnd: (_) {
                        setState((){updark = 0;});
                        _send('up&w');
                      },
                      child: Container(
                        color: currentThemeColors.buttonColor[updark],
                        padding: const EdgeInsets.all(80.0),
                        child: Icon(
                          Icons.arrow_upward,
                          color: currentThemeColors.buttonTextColor,
                          size: 45.0,
                        ),
                      ),
                    ),
                  ),
                ])));
  }
}
