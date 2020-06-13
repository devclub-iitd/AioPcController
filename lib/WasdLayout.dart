import 'package:aio_pc_controller/ButtonIcons.dart';
import 'package:aio_pc_controller/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config.dart';
import 'Theme.dart';
import 'dart:io';
import 'ButtonIcons.dart';

class WasdLayout extends StatefulWidget {
  @override
  _WasdLayoutState createState() => _WasdLayoutState();
}

class _WasdLayoutState extends State<WasdLayout> {
  int wdark = 0, adark = 0, shiftdark = 0, sdark = 0, ddark = 0, spacedark = 0;
  double w,h,wx,wy,ax,ay,sx,sy,dx,dy,shiftx,shifty,spacex,spacey,sz;
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

    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    sz=h*0.17;

    wx=w*0.85;
    wy=h*0.20;

    sx=w*0.85;
    sy=h*0.60;

    ax=w*0.10;
    ay=h*0.50;

    dx=w*0.30;
    dy=h*0.50;

    spacex=w*0.70;
    spacey=h*0.40;

    shiftx=w*0.20;
    shifty=h*0.25;

    return Scaffold(
      appBar: AppBar(
        title: Text("WASD"),
        actions: <Widget>[
          Container(
            child: Center(
                child: status == 'connected'
                    ? pingDisplay(sockStream)
                    : Text('Not Connected')),
            padding: EdgeInsets.only(right: w/20),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: wx-sz/2,
            top: wy-sz/2,
            child: GestureDetector(
              onPanStart: (_) {
                setState(() {
                  wdark = 1;
                });
                _send('down&w');
              },
              onPanEnd: (_) {
                setState(() {
                  wdark = 0;
                });
                _send('up&w');
              },
              child: Container(
                height: sz,
                width: sz,
                color: currentThemeColors.buttonColor[wdark],
                child: ButtonIcon('up', sz)
              ),
            ),
          ),
          Positioned(
            left: sx-sz/2,
            top: sy-sz/2,
            child: GestureDetector(
              onPanStart: (_) {
                setState(() {
                  sdark = 1;
                });
                _send('down&s');
              },
              onPanEnd: (_) {
                setState(() {
                  sdark = 0;
                });
                _send('up&s');
              },
              child: Container(
                height: sz,
                width: sz,
                color: currentThemeColors.buttonColor[sdark],
                child: ButtonIcon('down', sz)
              ),
            ),
          ),
          Positioned(
            left: spacex-sz/2,
            top: spacey-sz/2,
            child: GestureDetector(
              onPanStart: (_) {
                setState(() {
                  spacedark = 1;
                });
                _send('down&space');
              },
              onPanEnd: (_) {
                setState(() {
                  spacedark = 0;
                });
                _send('up&space');
              },
              child: Container(
                height: sz,
                width: sz,
                color: currentThemeColors.buttonColor[spacedark],
                child: ButtonIcon('space', sz)
              ),
            ),
          ),
          Positioned(
            left: shiftx-sz/2,
            top: shifty-sz/2,
            child: GestureDetector(
              onPanStart: (_) {
                setState(() {
                  shiftdark = 1;
                });
                _send('down&shift');
              },
              onPanEnd: (_) {
                setState(() {
                  shiftdark = 0;
                });
                _send('up&shift');
              },
              child: Container(
                height: sz,
                width: sz,
                color: currentThemeColors.buttonColor[shiftdark],
                child: ButtonIcon('shift', sz)
              ),
            ),
          ),
          Positioned(
            left: dx-sz/2,
            top: dy-sz/2,
            child: GestureDetector(
              onPanStart: (_) {
                setState(() {
                  ddark = 1;
                });
                _send('down&d');
              },
              onPanEnd: (_) {
                setState(() {
                  ddark = 0;
                });
                _send('up&d');
              },
              child: Container(
                height: sz,
                width: sz,
                color: currentThemeColors.buttonColor[ddark],
                child: ButtonIcon('right', sz)
              ),
            ),
          ),
          Positioned(
            left: ax-sz/2,
            top: ay-sz/2,
            child: GestureDetector(
              onPanStart: (_) {
                setState(() {
                  adark = 1;
                });
                _send('down&a');
              },
              onPanEnd: (_) {
                setState(() {
                  adark = 0;
                });
                _send('up&a');
              },
              child: Container(
                height: sz,
                width: sz,
                color: currentThemeColors.buttonColor[adark],
                child: ButtonIcon('left', sz),
              ),
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
    print("A");
    super.dispose();
    print("Disposed");
  }
}
