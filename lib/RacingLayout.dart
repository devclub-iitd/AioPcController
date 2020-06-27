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
  int wdark = 0, adark = 0, shiftdark = 0, sdark = 0, ddark = 0, spacedark = 0;
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
      shifth;
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

    spacew = w * 0.175;
    spaceh = h * 0.17;
    spacex = ax + aw / 2 - spacew / 2;
    spacey = h * 0.125;

    shiftw = w * 0.175;
    shifth = h * 0.17;
    shiftx = ax - aw / 2 + shiftw / 2;
    shifty = h * 0.125;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          RacingButton('A', ax, ay, aw, ah),
          RacingButton('D', dx, dy, dw, dh),
          RacingButton('S', sx, sy, sw, sh),
          RacingButton('space', spacex, spacey, spacew, spaceh),
          RacingButton('space', w - spacex, spacey, spacew, spaceh),
          RacingButton('shift', shiftx, shifty, shiftw, shifth),
          RacingButton('shift', w - shiftx, shifty, shiftw, shifth),
          Positioned(
            top: wy - wr,
            left: wx - wr,
            child: GestureDetector(
              child: Container(
                  height: 2 * wr,
                  width: 2 * wr,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: wr * 0.8,
                  ))),
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
    super.dispose();
  }
}

class RacingButton extends StatefulWidget {
  final String type;
  final double x, y, w, h;
  RacingButton(this.type, this.x, this.y, this.w, this.h);
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
            _send('down&${this.widget.type.toLowerCase()}');
          },
          onPanEnd: (_) {
            setState(() {
              darkness = 0;
            });
            _send('up&${this.widget.type.toLowerCase()}');
          },
        ));
  }

  void _send(char) {
    print("Sending " + char);
    sock.write('button' + '&' + char + '%');
  }
}
