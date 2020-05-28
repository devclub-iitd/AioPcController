import 'package:flutter/material.dart';
import 'dart:math';
import 'Dialogs.dart';
import 'ButtonIcons.dart';

class Custom extends StatefulWidget {
  
  @override
  CustomState createState() => new CustomState();
}

class CustomState extends State<Custom> {
  List<CustomButton> buttonList=[];
  var selected = 0;
  var minx = 1.0,
      maxx = 300.0,
      miny = 1.0,
      maxy = 300.0,
      minsz = 10.0,
      maxsz = 90.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Custom Layout"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: (){
                
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
        body:Stack(
          children: [
            Stack(children: buttonList),
            Positioned(
              bottom:0,
              child: Slider(
                value: getsz(),
                min: minsz,
                max: maxsz,
                divisions: 30,
                activeColor: Colors.red,
                inactiveColor: Colors.black,
                label: 'Set size',
                onChanged: (double newValue) {
                  try{
                    buttonList[selected].state.setState(() {
                      buttonList[selected].state.sz = newValue;
                    });
                    setState((){});
                  }
                  on Exception{}
                },
              )
            ) 
          ] 
        )
    );
  }
  double getsz(){
    if(selected >= buttonList.length){
      return minsz;
    }
    try{
      final sz = buttonList[selected].state.sz;
      return min(max(sz, minsz), maxsz);
    }
    on NoSuchMethodError{
      return minsz;
    }
  }
}


//CUSTOM BUTTON WIDGET !!


class CustomButton extends StatefulWidget {
  final CustomState parent;
  final int id;
  final String type;
  CustomButton(this.parent,this.id,this.type);
  CustomButtonState state;


  @override
  CustomButtonState createState(){
    this.state = new CustomButtonState();
    return this.state;
  }
}

class CustomButtonState extends State<CustomButton> {
  double x = 10.0;
  double y = 10.0;
  double sz = 50.0;

  @override
  Widget build(BuildContext context) {
    
    return Positioned(
      left: (x),
      top: (y),
      child: GestureDetector(
          child: Container(
            height: (sz),
            width: (sz),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                focalRadius: sz*3 ,
                colors: [Colors.orange, Colors.red]
              )
            ),

            padding: EdgeInsets.all(sz / 3),
            child: ButtonIcon(this.widget.type,sz),
          ),
          onTapDown: (_) {
            this.widget.parent.setState((){
              this.widget.parent.selected = this.widget.id;
            });
          },
          onPanUpdate: (tapInfo) {
            setState(() {
              x += tapInfo.delta.dx;
              y += tapInfo.delta.dy;
            });
          }),
    );
  }
}




