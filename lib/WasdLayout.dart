import 'package:aio_pc_controller/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config.dart';
import 'globals.dart';

class WasdLayout extends StatefulWidget {
  @override
  _WasdLayoutState createState() => _WasdLayoutState();
}

class _WasdLayoutState extends State<WasdLayout> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text("WASD"),
      ),
      body: Stack(
          children: <Widget>[
            Positioned(
              right: 100.0,
              top: 110.0,
              child: GestureDetector(
                onPanStart: (_) {
                   _send('down&w');
                },
                onPanEnd: (_) {
                   _send('up&w');
                },
                child: Container(
                  color: currentThemeColors.accentColor,
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
                   _send('down&s');
                },
                onPanEnd: (_) {
                   _send('up&s');
                },
                child: Container(
                  color: currentThemeColors.accentColor,
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
                   _send('down&space');
                },
                onPanEnd: (_) {
                   _send('up&space');
                },
                child: Container(
                  color: currentThemeColors.accentColor,
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
                   _send('down&shift');
                },
                onPanEnd: (_) {
                   _send('up&shift');
                },
                child: Container(
                  color: currentThemeColors.accentColor,
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
                   _send('down&d');
                },
                onPanEnd: (_) {
                   _send('up&d');
                },
                child: Container(
                  color: currentThemeColors.accentColor,
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
                   _send('down&a');
                },
                onPanEnd: (_) {
                   _send('up&a');
                },
                child: Container(
                  color: currentThemeColors.accentColor,
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
    sock.write('button'+'&'+char+'%');
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