import 'package:flutter/material.dart';
import '../Custom.dart';

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
