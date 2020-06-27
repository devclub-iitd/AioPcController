import 'dart:math';

import 'package:aio_pc_controller/ButtonIcons.dart';
import 'package:aio_pc_controller/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config.dart';
import 'Theme.dart';
import 'dart:io';
import 'ButtonIcons.dart';

class RacingLayout extends StatefulWidget {
  @override
  RacingLayoutState createState() => RacingLayoutState();
}

class RacingLayoutState extends State<RacingLayout> {
  bool toggle = false;
  int exitdark = 400;
  double w,
      h,
      ax,
      ay,
      aw,
      ah,
      dx,
      dy,
      dw,
      dh,
      wx,
      wy,
      wr,
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

    ax = w * 0.2;
    ay = h * 0.5;
    aw = w * 0.37;
    ah = h * 0.5;

    dx = w * 0.8;
    dy = h * 0.5;
    dw = w * 0.37;
    dh = h * 0.5;

    wx = w * 0.5;
    wy = h * 0.5;
    wr = h * 0.13;

    sx = w * 0.5;
    sy = h * 0.875;
    sw = w * 0.97;
    sh = h * 0.17;

    spacew = w * 0.18;
    spaceh = h * 0.17;
    spacex = ax + aw / 2 - spacew / 2;
    spacey = h * 0.125;

    shiftw = w * 0.18;
    shifth = h * 0.17;
    shiftx = ax - aw / 2 + shiftw / 2;
    shifty = h * 0.125;

    pingy = h * 0.1;

    exitx = w * 0.5;
    exity = h * 0.72;
    exitr = h / 30;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          RacingButton('left', 'a', ax, ay, aw, ah),
          RacingButton('right', 'd', dx, dy, dw, dh),
          RacingButton('down', 's', sx, sy, sw, sh),
          RacingButton('space', 'space', spacex, spacey, spacew, spaceh),
          RacingButton('space', 'space', w - spacex, spacey, spacew, spaceh),
          RacingButton('shift', 'shift', shiftx, shifty, shiftw, shifth),
          RacingButton('shift', 'shift', w - shiftx, shifty, shiftw, shifth),
          Positioned(
            top: wy - wr,
            left: wx - wr,
            child: GestureDetector(
              child: Container(
                  height: 2 * wr,
                  width: 2 * wr,
                  decoration: BoxDecoration(
                    color: toggle ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: wr * 0.8,
                  ))),
              onPanStart: (_) {
                setState(() {
                  toggle = !toggle;
                });
                if (toggle) {
                  _send('down&w');
                } else {
                  _send('up&w');
                }
              },
            ),
          ),
          Positioned(
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: pingy),
              child: status == 'connected'
                  ? pingDisplay(sockStream)
                  : noConnection(context),
            ),
          ),
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

  void _send(char) {
    print("Sending " + char);
    sock.write('button' + '&' + char + '%');
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
    if(toggle){
      _send('up&w');
    }
    super.dispose();
  }
}

class RacingButton extends StatefulWidget {
  final String type, mapping;
  final double x, y, w, h;
  RacingButton(this.type, this.mapping, this.x, this.y, this.w, this.h);
  @override
  RacingButtonState createState() => new RacingButtonState();
}

class RacingButtonState extends State<RacingButton> {
  int darkness = 0;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: this.widget.x - this.widget.w / 2,
        top: this.widget.y - this.widget.h / 2,
        child: GestureDetector(
          child: Container(
            height: (this.widget.h),
            width: (this.widget.w),
            color: currentThemeColors.buttonColor[darkness],
            padding: EdgeInsets.all(min(this.widget.w, this.widget.h) / 3),
            child:
                ButtonIcon(this.widget.type, min(this.widget.w, this.widget.h)),
          ),
          onPanStart: (_) {
            setState(() {
              darkness = 1;
            });
            _send('down&${this.widget.mapping.toLowerCase()}');
          },
          onPanEnd: (_) {
            setState(() {
              darkness = 0;
            });
            _send('up&${this.widget.mapping.toLowerCase()}');
          },
        ));
  }

  void _send(char) {
    print("Sending " + char);
    sock.write('button' + '&' + char + '%');
  }
}