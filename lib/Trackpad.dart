import 'package:aio_pc_controller/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config.dart';
import 'Theme.dart';
import 'dart:math';
import 'dart:io';

class Trackpad extends StatefulWidget {
  @override
  _TrackpadState createState() => _TrackpadState();
}

class _TrackpadState extends State<Trackpad> {

  var w, h;
  double dx=0, dy=0, time=0;
  String status;
  Stopwatch timer = new Stopwatch();
  int dark = 0;
  @override
  Widget build(BuildContext context) {
    if (sock == null) {
      status = 'null';
    } else {
      bool open = true;
      var test;
      try {
        sock.write('status&test%');
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Trackpad"),
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
              child: GestureDetector(
                onPanStart: (panInfo) {
                  setState((){
                    dark = 1;
                    time = 0;
                  });
                  timer.reset();
                  timer.start();
                  print("Pan Start");
                },
                onPanUpdate: (panInfo) {
                  setState(() {
                    dx += panInfo.delta.dx;
                    dy += panInfo.delta.dy;
                  });
                  print("Pan Update");
                  if((timer.elapsedMilliseconds/25).floor() >= time){
                    _send('move'+'&'+dx.toString()+'&'+dy.toString());
                    time++;
                    setState(() {
                      dx = dy = 0;
                    }); 
                  } 
                },
                onPanEnd: (panInfo) {
                  setState((){
                    dark = 0;
                    dx = dy = 0;
                  });
                  timer.reset();
                  print("Pan End");
                  print(panInfo);
                },
                child: Container(
                  width: w,
                  height: h,
                  color: currentThemeColors.buttonColor[dark],
                  padding: const EdgeInsets.all(20.0),
                ),
              ),
            ), 
          ],
        ),
      );
  }

  void _send(char){
    print("Sending " + char);
    if(sock == null) print("Could not send.");
    else sock.write('track' + '&' + char + '%');
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