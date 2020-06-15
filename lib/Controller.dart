import 'package:aio_pc_controller/Custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config.dart';
import 'dart:math';
import 'dart:io';

double slice(double x){
  return (x*100).round()/100;
}
class Controller extends StatefulWidget {
  @override
  ControllerState createState() => new ControllerState();
}

class ControllerState extends State<Controller> {
  String status;

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    cntdark = 100;
    toggle = false;
    _send('Toggle&0');
    super.dispose();
  }

  var w, h;
  double toph,
      rtx,
      rty,
      rbx,
      rby,
      ltx,
      lty,
      lbx,
      lby,
      ax,
      ay,
      r,
      xx,
      xy,
      yx,
      yy,
      bx,
      by,
      exitx,
      exity,
      exitr,
      pingx,
      pingy,
      cntx,
      cnty;
    
  int rtdark = 400,
      rbdark = 400,
      lbdark = 400,
      ltdark = 400,
      adark = 400,
      xdark = 400,
      ydark = 400,
      bdark = 400,
      exitdark = 400,
      cntdark = 100;

  double backx, backy, backh, backw, startx, starty, starth, startw;
  int backdark = 400, startdark = 400;

  double lsbdx = 0,
      lsbdy = 0,
      rsbdx = 0,
      rsbdy = 0,
      joyRange,
      joyR,
      axislx = 0,
      axisly = 0,
      axisrx = 0,
      axisry = 0,
      lsbx,
      lsby,
      rsbx,
      rsby;
  
  bool toggle = false;

  double dpadx, dpady, dpadh, dpadw;
  int updark = 400, downdark = 400, leftdark = 400, rightdark = 400;

  double joyx(double x, double dx, double y, double dy, double w, double h) {
    double jR = joyRange;
    if (dx * dx + dy * dy >= jR * jR) {
      return x + jR * dx / (sqrt(dx * dx + dy * dy));
    } else
      return x + dx;
  }

  double joyy(double x, double dx, double y, double dy, double w, double h) {
    double jR = joyRange;
    if (dx * dx + dy * dy >= jR * jR) {
      return y + jR * dy / (sqrt(dx * dx + dy * dy));
    } else
      return y + dy;
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
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

    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    toph = h / 8;
    rtx = w / 2;
    rty = 0.0;

    rbx = w / 2;
    rby = toph;

    ltx = 0.0;
    lty = 0.0;

    lbx = 0.0;
    lby = toph;

    r = h / 15;
    ax = yx = 7 * w / 9;
    ay = 5 * h / 9;

    xx = 7 * w / 9 - h / 9;
    xy = by = 4 * h / 9;

    yy = 3 * h / 9;
    bx = 7 * w / 9 + h / 9;

    exitx = w * 0.95;
    exity = h * 0.9;
    exitr = h / 30;

    backh = h / 10;
    backw = w / 10;
    backx = w / 2 - w / 9 - backw / 2;
    backy = h / 3 - backh / 2;

    starth = h / 10;
    startw = w / 10;
    startx = w / 2 + w / 9 - startw / 2;
    starty = h / 3 - starth / 2;

    joyRange = h / 10;
    joyR = h / 12;

    lsby = 5 * h / 9 - joyR;
    lsbx = 2 * w / 9 - joyR;
    rsby = 6.8 * h / 9 - joyR;
    rsbx = 5.5 * w / 9 - joyR;

    dpadx = 3.5 * w / 9;
    dpady = 7 * h / 9;
    dpadh = h / 9;
    dpadw = h / 12;

    pingx = w / 20;
    pingy = h * 0.9;

    cntx = w / 2;
    cnty = 4 * h / 9;
    return Scaffold(
        body: Stack(children: <Widget>[
      Positioned(
        top: rty,
        left: rtx,
        child: GestureDetector(
          child: Container(
            height: toph,
            width: w / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo[400], Colors.indigo[rtdark + 300]]),
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 0.1)),
            ),
            child: Center(
                child: Text(
              "RT",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
          ),
          onPanStart: (_) {
            _send('down&TriggerR');
            setState(() {
              rtdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&TriggerR');
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
            width: w / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo[400], Colors.indigo[rbdark + 300]]),
              border: Border(bottom: BorderSide(color: Colors.blue[900])),
            ),
            child: Center(
                child: Text(
              "RB",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
          ),
          onPanStart: (_) {
            _send('down&BtnShoulderR');
            setState(() {
              rbdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&BtnShoulderR');
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
            width: w / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo[ltdark + 300], Colors.indigo[400]]),
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 0.1)),
            ),
            child: Center(
                child: Text(
              "LT",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
          ),
          onPanStart: (_) {
            _send('down&TriggerL');
            setState(() {
              ltdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&TriggerL');
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
            width: w / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo[lbdark + 300], Colors.indigo[400]]),
              border: Border(bottom: BorderSide(color: Colors.blue[900])),
            ),
            child: Center(
                child: Text(
              "LB",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
          ),
          onPanStart: (_) {
            _send('down&BtnShoulderL');
            setState(() {
              lbdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&BtnShoulderL');
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
            height: 2 * r,
            width: 2 * r,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.green[adark], Colors.green[adark + 300]]),
              border: Border.all(color: Colors.green[900]),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text("A")),
          ),
          onPanStart: (_) {
            _send('down&BtnA');
            setState(() {
              adark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&BtnA');
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
            height: 2 * r,
            width: 2 * r,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.blue[xdark], Colors.blue[xdark + 300]]),
              border: Border.all(color: Colors.blue[900]),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text("X")),
          ),
          onPanStart: (_) {
            _send('down&BtnX');
            setState(() {
              xdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&BtnX');
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
            height: 2 * r,
            width: 2 * r,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.yellow[ydark], Colors.yellow[ydark + 300]]),
              border: Border.all(color: Colors.yellow[900]),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text("Y")),
          ),
          onPanStart: (_) {
            _send('down&BtnY');
            setState(() {
              ydark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&BtnY');
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
            height: 2 * r,
            width: 2 * r,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.red[bdark], Colors.red[bdark + 300]]),
              border: Border.all(color: Colors.red[900]),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text("B")),
          ),
          onPanStart: (_) {
            _send('down&BtnB');
            setState(() {
              bdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&BtnB');
            setState(() {
              bdark = 400;
            });
          },
        ),
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
                    RadialGradient(colors: [Colors.red[exitdark], Colors.black]),
                border: Border.all(color: Colors.black),
                shape: BoxShape.circle,
              ),
              child: Center(child: Icon(Icons.cancel))),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      Positioned(
        top: backy,
        left: backx,
        child: GestureDetector(
          child: Container(
              height: backh,
              width: backw,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      colors: [Colors.grey[backdark], Colors.grey]),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  )),
              child: Center(child: Icon(Icons.content_copy))),
          onPanStart: (_) {
            _send('down&BtnBack');
            setState(() {
              backdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&BtnBack');
            setState(() {
              backdark = 400;
            });
          },
        ),
      ),
      Positioned(
        top: starty,
        left: startx,
        child: GestureDetector(
          child: Container(
              height: backh,
              width: backw,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      colors: [Colors.grey[startdark], Colors.grey]),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  )),
              child: Center(child: Icon(Icons.dehaze))),
          onPanStart: (_) {
            _send('down&BtnStart');
            setState(() {
              startdark = 600;
            });
          },
          onPanEnd: (_) {
            _send('up&BtnStart');
            setState(() {
              startdark = 400;
            });
          },
        ),
      ),
      Positioned(
        top: lsby + joyR - joyRange,
        left: lsbx + joyR - joyRange,
        child: GestureDetector(
          child: Container(
            height: 2 * joyRange,
            width: 2 * joyRange,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
      Positioned(
        top: dpady - (dpadw + dpadh * 2) * 0.6,
        left: dpadx - (dpadw + dpadh * 2) * 0.6,
        child: GestureDetector(
          child: Container(
            height: (dpadw + dpadh * 2) * 1.2,
            width: (dpadw + dpadh * 2) * 1.2,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
      Positioned(
        top: rsby + joyR - joyRange,
        left: rsbx + joyR - joyRange,
        child: GestureDetector(
          child: Container(
            height: 2 * joyRange,
            width: 2 * joyRange,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
      Positioned(
        top: joyy(lsbx, lsbdx, lsby, lsbdy, w, h),
        left: joyx(lsbx, lsbdx, lsby, lsbdy, w, h),
        child: GestureDetector(
          child: Opacity(
            opacity: 0.8,
            child: Container(
              height: 2 * joyR,
              width: 2 * joyR,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.grey[400], Colors.grey[500]]),
                border: Border.all(color: Colors.grey[400]),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text("L")),
            ),
          ),
          onPanUpdate: (tapInfo) {
            setState(() {
              lsbdx += tapInfo.delta.dx;
              lsbdy += tapInfo.delta.dy;
              axislx = (lsbdx > 0)
                  ? min(lsbdx / joyRange, 1)
                  : max(lsbdx / joyRange, -1);
              axisly = (lsbdy > 0)
                  ? min(lsbdy / joyRange, 1)
                  : max(lsbdy / joyRange, -1);
            });
            _send('AxisLx&' + slice(axislx).toString());
            _send('AxisLy&' + slice((-axisly)).toString());
          },
          onPanEnd: (_) {
            setState(() {
              lsbdx = lsbdy = axislx = axisly = 0;
            });
            _send('AxisLx&0');
            _send('AxisLy&0');
          },
        ),
      ),
      Positioned(
        top: dpady - dpadw / 2,
        left: dpadx - dpadw / 2,
        child: GestureDetector(
          child: Container(
            height: dpadw,
            width: dpadh,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              border: Border.all(color: Colors.grey[400]),
            ),
          ),
        ),
      ),
      Positioned(
        top: joyy(rsbx, rsbdx, rsby, rsbdy, w, h),
        left: joyx(rsbx, rsbdx, rsby, rsbdy, w, h),
        child: GestureDetector(
          child: Opacity(
            opacity: 0.8,
            child: Container(
              height: 2 * joyR,
              width: 2 * joyR,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.grey[400], Colors.grey[500]]),
                border: Border.all(color: Colors.grey[400]),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text("R")),
            ),
          ),
          onPanUpdate: (tapInfo) {
            setState(() {
              rsbdx += tapInfo.delta.dx;
              rsbdy += tapInfo.delta.dy;
              axisrx = (rsbdx > 0)
                  ? min(rsbdx / joyRange, 1)
                  : max(rsbdx / joyRange, -1);
              axisry = (rsbdy > 0)
                  ? min(rsbdy / joyRange, 1)
                  : max(rsbdy / joyRange, -1);
            });
            _send('AxisRx&' + slice(axisrx).toString());
            _send('AxisRy&' + slice(-axisry).toString());
          },
          onPanEnd: (_) {
            setState(() {
              rsbdx = rsbdy = axisrx = axisry = 0;
            });
            _send('AxisRx&0');
            _send('AxisRy&0');
          },
        ),
      ),
      Positioned(
        top: dpady - dpadh - dpadw / 2,
        left: dpadx - dpadw / 2,
        child: GestureDetector(
          child: Container(
            height: dpadh,
            width: dpadw,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey[updark + 100], Colors.grey[updark]]),
              border: Border(
                  left: BorderSide(color: Colors.black, width: 0.5),
                  right: BorderSide(color: Colors.black, width: 0.5),
                  top: BorderSide(color: Colors.black, width: 0.5)),
            ),
          ),
          onPanStart: (_) {
            setState(() {
              updark = 500;
            });
            _send('Dpad&1');
          },
          onPanEnd: (_) {
            setState(() {
              updark = 400;
            });
            _send('Dpad&0');
          },
        ),
      ),
      Positioned(
        top: dpady + dpadw / 2,
        left: dpadx - dpadw / 2,
        child: GestureDetector(
          child: Container(
            height: dpadh,
            width: dpadw,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey[downdark], Colors.grey[downdark + 100]]),
              border: Border(
                  left: BorderSide(color: Colors.black, width: 0.5),
                  right: BorderSide(color: Colors.black, width: 0.5),
                  bottom: BorderSide(color: Colors.black, width: 0.5)),
            ),
          ),
          onPanStart: (_) {
            setState(() {
              downdark = 500;
            });
            _send('Dpad&2');
          },
          onPanEnd: (_) {
            setState(() {
              downdark = 400;
            });
            _send('Dpad&0');
          },
        ),
      ),
      Positioned(
        top: dpady - dpadw / 2,
        left: dpadx - dpadw / 2 - dpadh,
        child: GestureDetector(
          child: Container(
            height: dpadw,
            width: dpadh,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.grey[leftdark + 100], Colors.grey[leftdark]]),
              border: Border(
                  left: BorderSide(color: Colors.black, width: 0.5),
                  top: BorderSide(color: Colors.black, width: 0.5),
                  bottom: BorderSide(color: Colors.black, width: 0.5)),
            ),
          ),
          onPanStart: (_) {
            setState(() {
              leftdark = 500;
            });
            _send('Dpad&4');
          },
          onPanEnd: (_) {
            setState(() {
              leftdark = 400;
            });
            _send('Dpad&0');
          },
        ),
      ),
      Positioned(
        top: dpady - dpadw / 2,
        left: dpadx + dpadw / 2,
        child: GestureDetector(
          child: Container(
            height: dpadw,
            width: dpadh,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.grey[rightdark],
                Colors.grey[rightdark + 100]
              ]),
              border: Border(
                  right: BorderSide(color: Colors.black, width: 0.5),
                  top: BorderSide(color: Colors.black, width: 0.5),
                  bottom: BorderSide(color: Colors.black, width: 0.5)),
            ),
          ),
          onPanStart: (_) {
            setState(() {
              rightdark = 500;
            });
            _send('Dpad&8');
          },
          onPanEnd: (_) {
            setState(() {
              rightdark = 400;
            });
            _send('Dpad&0');
          },
        ),
      ),
      Positioned(
        top: pingy,
        left: pingx,
        child: Container(
          child: status == 'connected'
              ? pingDisplay(sockStream)
              : noConnection(context),
        ),
      ),
      Positioned(
        top: cnty,
        left: cntx,
        child: GestureDetector(
          child: Container(
            height: 1.5 * r,
            width: 1.5 * r,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.green[cntdark], Colors.green[cntdark]]),
              border: Border.all(color: Colors.yellow[900]),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text("CNT")),
          ),
          onPanStart: (_) {
            toggle = !toggle;
            if(toggle)
            {
              _send('Toggle&1');
            }
            else
            {
              _send('Toggle&0');
            }
            setState(() {
              if(toggle)
                cntdark = 300;
              else
                cntdark = 100;
            });
          },
        ),
      ),
    ]));
  }

  void _send(char) {
    if (sock == null)
      print("Could not send.");
    else
      sock.write('cont' + '&' + char + '%');
  }
}
