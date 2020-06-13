import 'package:aio_pc_controller/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config.dart';
import 'Theme.dart';
import 'dart:io';

class WasdLayout extends StatefulWidget {
  @override
  _WasdLayoutState createState() => _WasdLayoutState();
}

class _WasdLayoutState extends State<WasdLayout> {
  int wdark = 0, adark = 0, shiftdark = 0, sdark = 0, ddark = 0, spacedark = 0;
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
    return Scaffold(
      appBar: AppBar(
        title: Text("WASD"),
        actions: <Widget>[
          Container(
            child: Center(
                child: status == 'connected'
                    ? pingDisplay(sockStream)
                    : Text('Not Connected')),
            padding: const EdgeInsets.only(right: 30.0),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            right: 100.0,
            top: 110.0,
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
                color: currentThemeColors.buttonColor[wdark],
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.arrow_upward,
                  color: currentThemeColors.buttonTextColor,
                  size: 24.0,
                ),
              ),
            ),
          ),
          Positioned(
            right: 100.0,
            top: 220.0,
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
                color: currentThemeColors.buttonColor[sdark],
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.arrow_downward,
                  color: currentThemeColors.buttonTextColor,
                  size: 24.0,
                ),
              ),
            ),
          ),
          Positioned(
            right: 200.0,
            top: 165.0,
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
                color: currentThemeColors.buttonColor[spacedark],
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.space_bar,
                  color: currentThemeColors.buttonTextColor,
                  size: 24.0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 175.0,
            top: 70.0,
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
                color: currentThemeColors.buttonColor[shiftdark],
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.keyboard_capslock,
                  color: currentThemeColors.buttonTextColor,
                  size: 24.0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 250.0,
            top: 165.0,
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
                color: currentThemeColors.buttonColor[ddark],
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.arrow_forward,
                  color: currentThemeColors.buttonTextColor,
                  size: 24.0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 100.0,
            top: 165.0,
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
                color: currentThemeColors.buttonColor[adark],
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.arrow_back,
                  color: currentThemeColors.buttonTextColor,
                  size: 24.0,
                ),
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
