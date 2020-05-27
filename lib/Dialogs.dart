import 'package:flutter/material.dart';
import 'Custom.dart';

class ButtonChoice extends StatefulWidget{
  final CustomState parent;
  ButtonChoiceState state;
  ButtonChoice(this.parent);

  @override
  ButtonChoiceState createState(){
    this.state = new ButtonChoiceState();
    return this.state;
  } 
}

class ButtonChoiceState extends State<ButtonChoice>{
  String alphabet = 'A';
  @override 
  Widget build(BuildContext context){
    return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Container(
      height: 300.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Select Button Type:',
              style: TextStyle(color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
            child: Column(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    this.widget.parent.setState(() {
                      this.widget.parent.buttonList.add(
                          CustomButton(this.widget.parent, this.widget.parent.buttonList.length, alphabet));
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Alphabet (' + alphabet + ')',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                Slider(
                  value: alphabet.codeUnitAt(0).toDouble(),
                  min: 'A'.codeUnitAt(0).toDouble(),
                  max: 'Z'.codeUnitAt(0).toDouble(),
                  divisions: 30,
                  activeColor: Colors.red,
                  inactiveColor: Colors.black,
                  onChanged: (double newValue) {
                    setState((){
                      alphabet = String.fromCharCode(newValue.toInt());
                    });
                  },
                ),
                RaisedButton(
                  color: Colors.red,
                  onPressed: () {
                    this.widget.parent.setState(() {
                      this.widget.parent.buttonList.add(CustomButton(
                          this.widget.parent, this.widget.parent.buttonList.length, 'space'));
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Space',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                RaisedButton(
                  color: Colors.red,
                  onPressed: () {
                    this.widget.parent.setState(() {
                      this.widget.parent.buttonList.add(CustomButton(
                          this.widget.parent, this.widget.parent.buttonList.length, 'shift'));
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Shift',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }
}