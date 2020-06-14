import 'globals.dart';
import 'package:flutter/material.dart';
import 'config.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'Theme.dart';
import 'dart:io';

void tilt() {
  final subscription = accelerometerEvents.listen((AccelerometerEvent event) {
    gcurr = event.y * (event.x < 0 ? -1 : 1);
    if(gcurr>0)
    {
      gcurr = (asin(min(gcurr / 10, 1))/1.5707963267948966);
    }
    else
    {
      gcurr = -1*(asin(min((-1*gcurr) / 10, 1))/1.5707963267948966);
    }
  });
}

void _send(char) {
  print("Sending " + char);
  sock.write('button' + '&' + char + '%');
}

void tsend() {
  if (gcurr > 0.05) {
    String s = (min(gcurr*2, 1)).toString();
    sock.write("tilt&-&" + s + '%');
  } else if (gcurr < -0.05) {
    String s = (min(gcurr*-2, 1)).toString();
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
  String status;

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
    if (tiltcontrol) {
      sock.write("tilt&0%");
      tiltcontrol = false;
    }
    super.dispose();
  }

  int updark = 0, downdark = 0;
  @override
  Widget build(BuildContext context) {
    if (sock == null) {
      status = 'null';
    } else {
      bool open = true;
      var test;
      try {
        
void statusCheck() {
  pingClock.reset();
  pingClock.start();
  statusKey = statusKeyGenerator.nextInt(1000);
  var test;
  if(sock == null) return;
  try {  
        sock.write('status&'+statusKey.toString()+'%');
        test = sock.address.host;
        test = sock.remotePort;
      } on OSError {
        sock = null;
        return;
      } on SocketException {
        sock = null;
        return;
      } on NoSuchMethodError{
        sock = null;
        return;
      }
}

        test = sock.address.host;
        test = sock.remotePort;
        if (open) status = 'connected';
      } on OSError {
        sock = null;
        status = 'null';
        open = false;
      } on SocketException {
        sock = null;
        status = 'null';
        open = false;
      }
    }
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Tilt to Control"),
          actions: <Widget>[
            Container(
              child: Center(
                  child: status == 'connected'
                      ? pingDisplay(sockStream)
                      : noConnection(context),),
            ),
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
                        setState(() {
                          downdark = 1;
                        });
                        _send('down&s');
                      },
                      onPanEnd: (details) {
                        setState(() {
                          downdark = 0;
                        });
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
                        setState(() {
                          updark = 1;
                        });
                        _send('down&w');
                      },
                      onPanEnd: (_) {
                        setState(() {
                          updark = 0;
                        });
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
