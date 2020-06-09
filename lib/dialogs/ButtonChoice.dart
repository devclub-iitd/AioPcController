import 'package:aio_pc_controller/globals.dart';
import 'package:flutter/material.dart';
import '../Custom.dart';
import '../ButtonIcons.dart';

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
  String alphabet = 'A',number = '0';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Select button type',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: currentThemeColors.dialogTextColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(children: <Widget>[GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: RadialGradient(
                                  focalRadius: 40.0 * 3,
                                  colors: [Colors.orange, Colors.red])),
                          height: 40.0,
                          width: 40.0,
                          child: Center(child:Text(
                            alphabet,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          )),
                        ),
                        onTap: () {
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
                      ),
                      Center(
                          child: Text('Alphabet', style:TextStyle(fontSize: 10.0,color:currentThemeColors.dialogTextColor,fontWeight: FontWeight.bold)),
                        )
                      ],)
                      ,
                      Expanded(
                          child: Slider(
                        value: alphabet.codeUnitAt(0).toDouble(),
                        //value: 'A'.codeUnitAt(0).toDouble(),
                        min: 'A'.codeUnitAt(0).toDouble(),
                        max: 'Z'.codeUnitAt(0).toDouble(),
                        divisions: 25,
                        activeColor: Colors.red,
                        inactiveColor: Colors.black,
                        onChanged: (double newValue) {
                          setState(() {
                            alphabet = String.fromCharCode(newValue.toInt());
                          });
                        },
                      )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Column(children: <Widget>[
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: RadialGradient(
                                  focalRadius: 40.0 * 3,
                                  colors: [Colors.orange, Colors.red])),
                          height: 40.0,
                          width: 40.0,
                          child: Center(child:Text(
                            number,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          )),
                        ),
                        onTap: () {
                          this.widget.parent.setState(() {
                            this.widget.parent.buttonList.add(CustomButton(
                                this.widget.parent,
                                this.widget.parent.buttonList.length,
                                number,
                                10.0,
                                10.0,
                                50.0));
                          });
                          Navigator.of(context).pop();
                        },
                      ),Center(
                          child: Text('Digit', style:TextStyle(fontSize: 10.0,color:currentThemeColors.dialogTextColor,fontWeight: FontWeight.bold)),
                        )
                      ],),
                      Expanded(
                          child: Slider(
                        //value: number.codeUnitAt(0).toDouble(),
                        value: number.codeUnitAt(0).toDouble(),
                        min: '0'.codeUnitAt(0).toDouble(),
                        max: '9'.codeUnitAt(0).toDouble(),
                        divisions: 9,
                        activeColor: Colors.red,
                        inactiveColor: Colors.black,
                        onChanged: (double newValue) {
                          setState(() {
                            number = String.fromCharCode(newValue.toInt());
                          });
                        },
                      )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
 
                    children: <Widget>[
                      Column(
                      children: <Widget> [
                        GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: RadialGradient(
                                  focalRadius: 50.0 * 3,
                                  colors: [Colors.orange, Colors.red])),
                          padding: EdgeInsets.all(50.0 / 3),
                          height: 50.0,
                          width: 50.0,
                          child: Center(child:
                            ButtonIcon('shift',50.0),
                          ),
                        ),
                        onTap: () {
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
                    }),
                    
                       Center(
                          child: Text('Shift', style:TextStyle(fontSize: 11.0,color:currentThemeColors.dialogTextColor,fontWeight: FontWeight.bold)),
                        )
                      ],),
                      
                      Column(
                      children: <Widget> [
                        GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: RadialGradient(
                                  focalRadius: 50.0 * 3,
                                  colors: [Colors.orange, Colors.red])),
                          padding: EdgeInsets.all(50.0 / 3),
                          height: 50.0,
                          width: 50.0,
                          child: Center(child:
                            ButtonIcon('space',50.0),
                          ),
                        ),
                        onTap: () {
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
                    }),
                    
                       Center(
                          child: Text('Space', style:TextStyle(fontSize: 11.0,color:currentThemeColors.dialogTextColor,fontWeight: FontWeight.bold)),
                        )
                      ],)
                      
                    ],
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
