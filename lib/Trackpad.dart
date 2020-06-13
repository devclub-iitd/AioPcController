import 'package:aio_pc_controller/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config.dart';
import 'Theme.dart';
import 'dart:math';
import 'dart:io';

class Trackpad extends StatefulWidget {
  @override
  TrackpadState createState() => TrackpadState();
}

class TrackpadState extends State<Trackpad> {
  var w, h;
  double dx = 0, dy = 0, time = 0;
  double exitx, exity, exitr;
  String status;
  @override
  Widget build(BuildContext context) {
    if (sock == null) {
      status = 'null';
    } else {
      bool open = true;
      var test;
      try {
        sock.write('status&' + statusKey.toString() + '%');
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    exitx = w * 0.95;
    exity = h * 0.9;
    exitr = h / 30;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TrackpadDetector(this),
          Positioned(
            right: 0.05 * w,
            top: 0.07 * h,
            child: Center(
                child: status == 'connected'
                    ? pingDisplay(sockStream)
                    : Text('Not Connected')),
          ),
          Positioned(
            top: exity,
            left: exitx,
            child: GestureDetector(
              child: Container(
                  height: 2 * exitr,
                  width: 2 * exitr,
                  decoration: BoxDecoration(
                    gradient:
                        RadialGradient(colors: [Colors.red[400], Colors.black]),
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

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}

class TrackpadDetector extends StatefulWidget {
  final TrackpadState parent;

  TrackpadDetector(this.parent);
  @override
  TrackpadDetectorState createState() => TrackpadDetectorState();
}

class TrackpadDetectorState extends State<TrackpadDetector> {
  int ldark = 0, rdark = 0;
  double dx = 0,
      dy = 0,
      time = 0,
      x = -1000,
      y = -1000,
      sz,
      padh,
      padw,
      clickh,
      clickw,
      clickmargin;
  Stopwatch timer = new Stopwatch();

  @override
  Widget build(BuildContext context) {
    double w = this.widget.parent.w, h = this.widget.parent.h;

    sz = w / 15;

    padw = w;
    padh = h * 0.80;

    clickmargin = h * 0.015;
    clickw = w / 2 - 2 * clickmargin;
    clickh = h * 0.20 - 2 * clickmargin;

    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: GestureDetector(
            onPanStart: (panInfo) {
              setState(() {
                time = 0;
                x = panInfo.globalPosition.dx - sz / 2;
                y = panInfo.globalPosition.dy - sz / 2;
              });
              timer.reset();
              timer.start();
            },
            onPanUpdate: (panInfo) {
              setState(() {
                dx += panInfo.delta.dx;
                dy += panInfo.delta.dy;
                x += panInfo.delta.dx;
                y += panInfo.delta.dy;
              });
              print(panInfo.globalPosition.dx);
              if ((timer.elapsedMilliseconds / 25).floor() >= time) {
                _send('move' + '&' + dx.toString() + '&' + dy.toString());
                time++;
                setState(() {
                  dx = dy = 0;
                });
              }
            },
            onPanEnd: (panInfo) {
              setState(() {
                dx = dy = 0;
                x = y = -1000;
              });
              timer.reset();
              print(panInfo);
            },
            child: Container(
              width: padw,
              height: padh,
              color: currentThemeColors.primaryBackgroundColor,
            ),
          ),
        ),
        Positioned(
          top: h * 0.80,
          left: 0,
          child: GestureDetector(
            onPanStart: (_) {
              setState(() {
                ldark = 1;
              });
              _send('click&down&left');
            },
            onPanEnd: (_) {
              setState(() {
                ldark = 0;
              });
              _send('click&up&left');
            },
            child: Container(
              margin: EdgeInsets.all(clickmargin),
              width: clickw,
              height: clickh,
              decoration: BoxDecoration(
                color: currentThemeColors.buttonColor[ldark],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        Positioned(
          top: h * 0.80,
          left: w / 2,
          child: GestureDetector(
            onPanStart: (_) {
              setState(() {
                rdark = 1;
              });
              _send('click&down&right');
            },
            onPanEnd: (_) {
              setState(() {
                rdark = 0;
              });
              _send('click&up&right');
            },
            child: Container(
              margin: EdgeInsets.all(clickmargin),
              width: clickw,
              height: clickh,
              decoration: BoxDecoration(
                color: currentThemeColors.buttonColor[rdark],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        Positioned(
          top: y,
          left: x,
          child: Container(
            child: Opacity(
              opacity: 0.8,
              child: Container(
                height: sz,
                width: sz,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                      colors: [Colors.grey[400], Colors.grey[600]]),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _send(char) {
    print("Sending " + char);
    sock.write('track' + '&' + char + '%');
  }
}
