import 'package:aio_pc_controller/globals.dart';
import 'package:flutter/material.dart';
import '../Custom.dart';
import '../DatabaseHelper.dart';

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
  String error = '';
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
                  value = value.trim();
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
              Row(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("$error",
                          style: TextStyle(fontSize: 9, color: Colors.red)))
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton(
                    onPressed: () async {
                      setState((){ error = ''; });
                      
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
                          this
                              .widget
                              .parent
                              .scaffoldKey
                              .currentState
                              .showSnackBar(SnackBar(
                                content: Text(
                                    'Created and saved layout "${layoutName.text}"'),
                                duration: Duration(seconds: 2),
                              ));
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            error =
                                'A layout with name "${layoutName.text}" already exists.';
                          });
                        }
                      }
                    },
                    child: Text('Save'),
                    color: currentThemeColors.dialogButtonColor,
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
