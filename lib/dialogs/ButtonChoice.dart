import 'package:flutter/material.dart';
import '../Custom.dart';
import '../DatabaseHelper.dart';

class ButtonChoice extends StatefulWidget {
  final CustomState parent;
  ButtonChoiceState state;
  ButtonChoice(this.parent);

  @override
  ButtonChoiceState createState() {
    this.state = new ButtonChoiceState();
    return this.state;
  }
}


class ButtonChoiceState extends State<ButtonChoice> {
  String alphabet = 'A';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: const EdgeInsets.only(
            top: 30.0, bottom: 30.0, left: 10.0, right: 10.0),
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Select button type',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      this.widget.parent.setState(() {
                        this.widget.parent.buttonList.add(CustomButton(
                            this.widget.parent,
                            this.widget.parent.buttonList.length,
                            alphabet,
                            10.0,
                            10.0,
                            50.0));
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
                      setState(() {
                        alphabet = String.fromCharCode(newValue.toInt());
                      });
                    },
                  ),
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      this.widget.parent.setState(() {
                        this.widget.parent.buttonList.add(CustomButton(
                            this.widget.parent,
                            this.widget.parent.buttonList.length,
                            'space',
                            10.0,
                            10.0,
                            50.0));
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
                            this.widget.parent,
                            this.widget.parent.buttonList.length,
                            'shift',
                            10.0,
                            10.0,
                            50.0));
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