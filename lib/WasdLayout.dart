import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config.dart';

class WasdLayout extends StatefulWidget {
  @override
  _WasdLayoutState createState() => _WasdLayoutState();
}

class _WasdLayoutState extends State<WasdLayout> {
  Stopwatch stopwatch = new Stopwatch();
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
                onTapDown: (_) {
                   _send('down&w');
                },
                onTapCancel: () { 
                  _send('up&w'); 
                },
                onTapUp: (_) {
                   _send('up&w');
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 100.0,
              top: 220.0,
              child: GestureDetector(
                onTapDown: (_) {
                   _send('down&s');
                },
                onTapCancel: () { 
                  _send('up&s');
                },
                onTapUp: (_) {
                   _send('up&s');
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 200.0,
              top: 165.0,
              child: GestureDetector(
                onTapDown: (_) {
                   _send('down&shift');
                },
                onTapCancel: () { 
                  _send('up&shift');
                },
                onTapUp: (_) {
                   _send('up&shift');
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Sh',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 175.0,
              top: 70.0,
              child: GestureDetector(
                onTapDown: (_) {
                   _send('down&space');
                },
                onTapCancel: () { 
                  _send('up&space');
                },
                onTapUp: (_) {
                   _send('up&space');
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Sp',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 250.0,
              top: 165.0,
              child: GestureDetector(
                onTapDown: (_) {
                   _send('down&d');
                },
                onTapCancel: () { 
                  _send('up&d');
                },
                onTapUp: (_) {
                   _send('up&d');
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 100.0,
              top: 165.0,
              child: GestureDetector(
                onTapDown: (_) {
                   _send('down&a');
                },
                onTapCancel: () { 
                  _send('up&a');
                },
                onTapUp: (_) {
                   _send('up&a');
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
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
    stopwatch.reset();
    stopwatch.start();
    sock.write('wasd'+'&'+char+'%');
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