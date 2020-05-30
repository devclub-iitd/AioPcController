import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'Custom.dart';
import 'DatabaseHelper.dart';
import 'LoadCustom.dart';

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

class LayoutSave extends StatefulWidget {
  final CustomState parent;
  LayoutSaveState state;
  LayoutSave(this.parent);

  @override
  LayoutSaveState createState() {
    this.state = new LayoutSaveState();
    return this.state;
  }
}

class LayoutSaveState extends State<LayoutSave> {
  TextEditingController layoutName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: 300.0,
        padding: const EdgeInsets.only(
            top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: layoutName,
                decoration:
                    InputDecoration(labelText: 'Enter the name of the layout'),
                validator: (value) {
                  // value = value.trim();
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else {
                    String name = '$value';
                    for (int i = 0; i < name.length; i++) {
                      var ch = name.codeUnitAt(i);
                      if (ch != 32 &&
                          !(ch >= 48 && ch <= 57) &&
                          !(ch >= 65 && ch <= 90) &&
                          !(ch >= 97 && ch <= 122))
                        return 'Layout name must only consist of digits, alphabets and spaces';
                    }
                  }
                  return null;
                },
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var check = await createTable(layoutName.text);
                        if (check) {
                          List<Map<String, dynamic>> buttonONList = [];
                          for (int i = 0;
                              i < this.widget.parent.buttonList.length;
                              i++) {
                            buttonONList
                                .add(this.widget.parent.buttonList[i].toMap());
                          }
                          saveButtons(buttonONList, layoutName.text);
                          this.widget.parent.layoutName = layoutName.text;
                          this.widget.parent.setState(() {});
                          this.widget.parent.scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                    'Created and saved layout "${layoutName.text}"'),
                                duration: Duration(seconds: 2),
                              ));
                          Navigator.pop(context);
                        } else {
                          this.widget.parent.scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                    'There already exists a layout with name "${layoutName.text}"'),
                                duration: Duration(seconds: 2),
                              ));
                        }
                      }
                    },
                    child: Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonDelete extends StatefulWidget {
  final CustomButtonState parent;
  ButtonDeleteState state;
  ButtonDelete(this.parent);

  @override
  ButtonDeleteState createState() {
    this.state = new ButtonDeleteState();
    return this.state;
  }
}

class ButtonDeleteState extends State<ButtonDelete> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: 300.0,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Are you sure you want to delete this button?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RaisedButton(
                      onPressed: () {
                        this
                            .widget
                            .parent
                            .widget
                            .parent
                            .deleteButton(this.widget.parent.widget.id);
                        Navigator.pop(context);
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('Yes, Delete'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LayoutDelete extends StatefulWidget {
  final LoadCustomState parent;
  final String layoutName;
  LayoutDeleteState state;
  LayoutDelete(this.parent, this.layoutName);

  @override
  LayoutDeleteState createState() {
    this.state = new LayoutDeleteState();
    return this.state;
  }
}

class LayoutDeleteState extends State<LayoutDelete> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: 500.0,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Are you sure you want to delete this layout?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RaisedButton(
                      onPressed: () {
                        deleteTable(this.widget.layoutName);
                        Navigator.pop(context);
                        refresh(this.widget.parent.context);
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('Yes'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
