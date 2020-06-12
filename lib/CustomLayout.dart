import 'package:flutter/material.dart';
import 'Theme.dart';
import 'config.dart';
import 'ButtonIcons.dart';
import 'DatabaseHelper.dart';
import 'globals.dart';
import 'dart:io';
String globalLayoutName;
List globalLayoutButtonList;

class CustomLayout extends StatefulWidget {
  @override
  _CustomLayoutState createState() => _CustomLayoutState();
}

class _CustomLayoutState extends State<CustomLayout> {
  List<LayoutButton> layoutButtonList = [];
  String status;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
    for(int i=0;i<globalLayoutButtonList.length;i++){
      layoutButtonList.add(new LayoutButton(globalLayoutButtonList[i]['type'],globalLayoutButtonList[i]['x'],globalLayoutButtonList[i]['y'],globalLayoutButtonList[i]['sz']));
    }
    globalLayoutButtonList = [];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(globalLayoutName),
        actions: <Widget>[
          Container(
            child: status == 'connected' ? pingDisplay(sockStream) : Text(''),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  tiltcontrol = !tiltcontrol;
                });
                if (!tiltcontrol) sock.write("tilt&0%");
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Tilting mode has been turned ' +
                        (tiltcontrol ? 'ON' : 'OFF')),
                    duration: Duration(milliseconds: 400)));
              },
              icon: Icon(Icons.rotate_left,
                  color: tiltcontrol ? Colors.green : Colors.red),
          ),
        ],
      ),
      body: Stack(
        children: layoutButtonList,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if(tiltcontrol){
      sock.write("tilt&0%");
      tiltcontrol = false;
    }
  }
}

class LayoutButton extends StatefulWidget{
  final String type;
  final double x, y, sz;
  LayoutButton(this.type, this.x, this.y, this.sz);
  @override
  LayoutButtonState createState() => new LayoutButtonState();
}
class LayoutButtonState extends State<LayoutButton> {
  int darkness = 0;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: this.widget.x,
      top: this.widget.y,
      child: GestureDetector(
        child: Container(
          height: (this.widget.sz),
          width: (this.widget.sz),
          color: currentThemeColors.buttonColor[darkness],
          padding: EdgeInsets.all(this.widget.sz / 3),
          child: ButtonIcon(this.widget.type, this.widget.sz),
        ),
        onPanStart: (_) {
          setState((){
            darkness = 1;
          });
          _send('down&${this.widget.type.toLowerCase()}');
        },
        onPanEnd: (_) {
          setState((){
            darkness = 0;
          });
          _send('up&${this.widget.type.toLowerCase()}');
        },
      )
    );
  }

  void _send(char) {
    print("Sending " + char);
    sock.write('button' + '&' + char + '%');
  }
}

void customLayoutLoader(context, layoutName) async{
  globalLayoutName = layoutName;
  globalLayoutButtonList = await getLayoutData(layoutName);
  Navigator.pushNamed(context, '/custom_layout');
}