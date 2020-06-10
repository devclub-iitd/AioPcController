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
  double dx, dy;
  int dark = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Trackpad"),
      ),
      body: Stack(
          children: <Widget>[
            Positioned(
              child: GestureDetector(
                onPanStart: (panInfo) {
                  setState((){dark = 1;});
                },
                onPanUpdate: (panInfo) {
                  setState(() {
                    dx=panInfo.delta.dx;
                    dy=panInfo.delta.dy;
                  });
                  print('$dx'+'$dy');
                  //_send('move'+'&'+dx.toString()+'&'+dy.toString());
                },
                onPanEnd: (panInfo) {
                  setState((){
                    dark = 0;
                    dx = dy = 0;
                  });
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