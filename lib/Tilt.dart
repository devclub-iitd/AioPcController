import 'globals.dart';
import 'package:flutter/material.dart';
import 'config.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'Theme.dart';
import 'dart:io';
import 'RacingLayout.dart';

void tilt() {
  final subscription = accelerometerEvents.listen((AccelerometerEvent event) {
    gcurr = event.y * (event.x < 0 ? -1 : 1);
    if (gcurr > 0) {
      gcurr = (asin(min(gcurr / 10, 1)) / 1.5707963267948966);
    } else {
      gcurr = -1 * (asin(min((-1 * gcurr) / 10, 1)) / 1.5707963267948966);
    }
  });
}

void _send(char) {
  print("Sending " + char);
  sock.write('button' + '&' + char + '%');
}

void tsend() {
  if (gcurr > 0.05) {
    String s = (min(gcurr * 2, 1)).toStringAsFixed(2);
    sock.write("tilt&-&" + s + '%');
  } else if (gcurr < -0.05) {
    String s = (min(gcurr * -2, 1)).toStringAsFixed(2);
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
  int exitdark = 400;
  double w,
      h,
      wx,
      wy,
      ww,
      wh,
      sx,
      sy,
      sw,
      sh,
      spacex,
      spacey,
      spacew,
      spaceh,
      shiftx,
      shifty,
      shiftw,
      shifth,
      pingy,
      exitx,
      exity,
      exitr;
  String status;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    if (tiltcontrol) {
      sock.write("tilt&toggle&0%");
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
          if (sock == null) return;
          try {
            sock.write('status&' + statusKey.toString() + '%');
            test = sock.address.host;
            test = sock.remotePort;
          } on OSError {
            sock = null;
            return;
          } on SocketException {
            sock = null;
            return;
          } on NoSuchMethodError {
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

    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    wx = w * 0.2;
    wy = h * 0.5;
    ww = w * 0.37;
    wh = h * 0.5;

    sx = w * 0.5;
    sy = h * 0.875;
    sw = w * 0.97;
    sh = h * 0.17;

    spacew = w * 0.18;
    spaceh = h * 0.17;
    spacex = wx + ww / 2 - spacew / 2;
    spacey = h * 0.125;

    shiftw = w * 0.18;
    shifth = h * 0.17;
    shiftx = wx - ww / 2 + shiftw / 2;
    shifty = h * 0.125;

    pingy = h * 0.1;

    exitx = w * 0.5;
    exity = h * 0.72;
    exitr = h / 30;

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          RacingButton('up', 'w', wx, wy, ww, wh),
          RacingButton('up', 'w', w - wx, wy, ww, wh),
          RacingButton('down', 's', sx, sy, sw, sh),
          RacingButton('space', 'space', spacex, spacey, spacew, spaceh),
          RacingButton('space', 'space', w - spacex, spacey, spacew, spaceh),
          RacingButton('shift', 'shift', shiftx, shifty, shiftw, shifth),
          RacingButton('shift', 'shift', w - shiftx, shifty, shiftw, shifth),
          Column(children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: pingy),
              child: status == 'connected'
                  ? pingDisplay(sockStream)
                  : noConnection(context),
            ),
            Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: pingy),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      tiltcontrol = !tiltcontrol;
                    });
                    if (!tiltcontrol) sock.write("tilt&toggle&0%");
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text('Tilting mode has been turned ' +
                            (tiltcontrol ? 'ON' : 'OFF')),
                        duration: Duration(milliseconds: 400)));
                  },
                  icon: Icon(Icons.rotate_left,
                      color: tiltcontrol ? Colors.green : Colors.red),
                ))
          ]),
          Positioned(
            top: exity - exitr,
            left: exitx - exitr,
            child: GestureDetector(
              child: Container(
                  height: 2 * exitr,
                  width: 2 * exitr,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                        colors: [Colors.red[exitdark], Colors.black]),
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Icon(Icons.cancel))),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
