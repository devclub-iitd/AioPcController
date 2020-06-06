import 'package:aio_pc_controller/Custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config.dart';

class Controller extends StatefulWidget {
  @override
  ControllerState createState() => new ControllerState();
}

class ControllerState extends State<Controller> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  var w, h;
  double toph, rtx, rty, rbx, rby, ltx, lty, lbx, lby, ax, ay, r, xx, xy, yx, yy, bx, by;
  int rtdark = 400, rbdark = 400, lbdark = 400, ltdark = 400, adark = 400, xdark = 400, ydark = 400, bdark = 400;

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    toph = h / 8;
    rtx = w / 2;
    rty = 0.0;

    rbx = w/2;
    rby = toph;

    ltx = 0.0;
    lty = 0.0;

    lbx = 0.0;
    lby = toph;

    r = h/15;
    ax = yx = 7*w/9;
    ay = 5*h/9;

    xx = 7*w/9 - h/9;
    xy = by = 4*h/9;

    yy = 3*h/9;
    bx = 7*w/9 + h/9;
    

    return Scaffold(
        body: Stack(children: <Widget>[
      Positioned(
        top: rty,
        left: rtx,
        child: GestureDetector(
          child: Container(
            height: toph,
            width: w/2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[rtdark], Colors.blue[rtdark + 300]]),
                border: Border(bottom: BorderSide(color:Colors.white,width:0.1)),
            ),
            child: Center(child:Text("RT")),
          ),
          onPanStart: (_) {
            _send('down&rt');
            setState(() {
              rtdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&rt');
            setState(() {
              rtdark = 400;
            });
          },
        ),
      ),
      Positioned(
        top: rby,
        left: rbx,
        child: GestureDetector(
          child: Container(
            height: toph,
            width: w/2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[rbdark], Colors.blue[rbdark + 300]]),
                border: Border(bottom: BorderSide(color:Colors.blue[900])),
            ),
            child: Center(child:Text("RB")),
          ),
          onPanStart: (_) {
            _send('down&rb');
            setState(() {
              rbdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&rb');
            setState(() {
              rbdark = 400;
            });
          },
        ),
      ),
      Positioned(
        top: lty,
        left: ltx,
        child: GestureDetector(
          child: Container(
            height: toph,
            width: w/2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[ltdark + 300],Colors.blue[ltdark]]),
                border: Border(bottom: BorderSide(color:Colors.white,width:0.1)),
            ),
            child: Center(child:Text("LT")),
          ),
          onPanStart: (_) {
            _send('down&lt');
            setState(() {
              ltdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&lt');
            setState(() {
              ltdark = 400;
            });
          },
        ),
      ),
      Positioned(
        top: lby,
        left: lbx,
        child: GestureDetector(
          child: Container(
            height: toph,
            width: w/2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[lbdark + 300],Colors.blue[lbdark]]),
                border: Border(bottom: BorderSide(color:Colors.blue[900])),
            ),
            child: Center(child:Text("LB")),
          ),
          onPanStart: (_) {
            _send('down&lb');
            setState(() {
              lbdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&lb');
            setState(() {
              lbdark = 400;
            });
          },
        ),
      ),
      Positioned(
        top: ay,
        left: ax,
        child: GestureDetector(
          child: Container(
            height: 2*r,
            width: 2*r,
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.green[adark],Colors.green[adark+300]]),
                border: Border.all(color:Colors.green[900]),
                shape: BoxShape.circle,
            ),
            child: Center(child:Text("A")),
          ),
          onPanStart: (_) {
            _send('down&a');
            setState(() {
              adark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&a');
            setState(() {
              adark = 400;
            });
          },
        ),
      ),
      Positioned(
        top: xy,
        left: xx,
        child: GestureDetector(
          child: Container(
            height: 2*r,
            width: 2*r,
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.blue[xdark],Colors.blue[xdark+300]]),
                border: Border.all(color:Colors.blue[900]),
                shape: BoxShape.circle,
            ),
            child: Center(child:Text("X")),
          ),
          onPanStart: (_) {
            _send('down&x');
            setState(() {
              xdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&x');
            setState(() {
              xdark = 400;
            });
          },
        ),
      ),
      Positioned(
        top: yy,
        left: yx,
        child: GestureDetector(
          child: Container(
            height: 2*r,
            width: 2*r,
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.yellow[ydark],Colors.yellow[ydark+300]]),
                border: Border.all(color:Colors.yellow[900]),
                shape: BoxShape.circle,
            ),
            child: Center(child:Text("Y")),
          ),
          onPanStart: (_) {
            _send('down&y');
            setState(() {
              ydark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&y');
            setState(() {
              ydark = 400;
            });
          },
        ),
      ),
      Positioned(
        top: by,
        left: bx,
        child: GestureDetector(
          child: Container(
            height: 2*r,
            width: 2*r,
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.red[bdark],Colors.red[bdark+300]]),
                border: Border.all(color:Colors.red[900]),
                shape: BoxShape.circle,
            ),
            child: Center(child:Text("B")),
          ),
          onPanStart: (_) {
            _send('down&b');
            setState(() {
              bdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&b');
            setState(() {
              bdark = 400;
            });
          },
        ),
      ),
    ]));
  }

  void _send(char) {
    print("Sending " + char);
    if(sock == null) print("Could not send.");
    else sock.write('cont' + '&' + char + '%');
  }
}
