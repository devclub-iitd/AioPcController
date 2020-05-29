import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'Dialogs.dart';
import 'ButtonIcons.dart';
import 'DatabaseHelper.dart';

class Custom extends StatefulWidget {
  @override
  CustomState createState() => new CustomState();
}

class CustomState extends State<Custom> {
  var layoutName = 'untitled';
  List<CustomButton> buttonList = [];

  var selected = 0;
  var minsz = 10.0, maxsz = 90.0;
  void deleteButton(int id){
    buttonList[id].state.setState((){
      buttonList[id].x = -100;
      buttonList[id].y = -100;
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Custom Layout"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (layoutName != 'untitled') {
                  List<Map<String,dynamic>> buttonONList = [];
                  for(int i=0;i<buttonList.length;i++){
                    buttonONList.add(buttonList[i].toMap());
                  }
                  saveButtons(buttonONList,layoutName);
                  scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Changes saved to "$layoutName"'),
                    duration: Duration(seconds: 2),
                  ));
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LayoutSave(this);
                    },
                  );
                }
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ButtonChoice(this);
              },
            );
          },
        ),
        body: Stack(children: [
          Stack(children: buttonList),
          Positioned(
              bottom: 0,
              child: Slider(
                value: getsz(),
                min: minsz,
                max: maxsz,
                divisions: 30,
                activeColor: Colors.red,
                inactiveColor: Colors.black,
                label: 'Set size',
                onChanged: (double newValue) {
                  try {
                    buttonList[selected].state.setState(() {
                      buttonList[selected].sz = newValue;
                    });
                    setState((){});
                  } on Exception {}
                },
              ))
        ]));
  }

  double getsz() {
    if (selected >= buttonList.length) {
      return minsz;
    }
    try {
      final sz = buttonList[selected].sz;
      return min(max(sz, minsz), maxsz);
    } on NoSuchMethodError {
      return minsz;
    }
  }
}

//CUSTOM BUTTON WIDGET !!

class CustomButton extends StatefulWidget {
  final CustomState parent;
  int id;
  final String type;
  double x = 10.0;
  double y = 10.0;
  double sz = 50.0;
  CustomButton(this.parent, this.id, this.type);
  CustomButtonState state;

  Map<String, dynamic> toMap() {
    return {'type': type, 'x': x, 'y':y, 'sz':sz};
  }

  @override
  CustomButtonState createState() {
    this.state = new CustomButtonState();
    return this.state;
  }

}

class CustomButtonState extends State<CustomButton> {
  

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (widget.x),
      top: (widget.y),
      child: GestureDetector(
          child: Container(
            height: (widget.sz),
            width: (widget.sz),
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    focalRadius: widget.sz * 3, colors: [Colors.orange, Colors.red])),
            padding: EdgeInsets.all(widget.sz / 3),
            child: ButtonIcon(this.widget.type, widget.sz),
          ),
          onTap: () {
            this.widget.parent.setState(() {
              this.widget.parent.selected = this.widget.id;
            });
          },
          onLongPress: () {
            HapticFeedback.vibrate();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ButtonDelete(this);
              },
            );
          },
          onPanUpdate: (tapInfo) {
            setState(() {
              widget.x += tapInfo.delta.dx;
              widget.y += tapInfo.delta.dy;
            });
          }),
    );
  }
}
