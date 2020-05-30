import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config.dart';
import 'ButtonIcons.dart';
import 'DatabaseHelper.dart';

String globalLayoutName;
List globalLayoutButtonList;

class CustomLayout extends StatefulWidget {
  @override
  _CustomLayoutState createState() => _CustomLayoutState();
}

class _CustomLayoutState extends State<CustomLayout> {
  List<LayoutButton> layoutButtonList = [];
  @override
  Widget build(BuildContext context) {
    for(int i=0;i<globalLayoutButtonList.length;i++){
      layoutButtonList.add(new LayoutButton(globalLayoutButtonList[i]['type'],globalLayoutButtonList[i]['x'],globalLayoutButtonList[i]['y'],globalLayoutButtonList[i]['sz']));
    }
    globalLayoutButtonList = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(globalLayoutName),
      ),
      body: Stack(
        children: layoutButtonList,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("Disposed");
  }
}

class LayoutButton extends StatelessWidget {
  final String type;
  final double x, y, sz;
  LayoutButton(this.type, this.x, this.y, this.sz);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: this.x,
      top: this.y,
      child: GestureDetector(
        child: Container(
          height: (this.sz),
          width: (this.sz),
          color: Colors.blue,
          padding: EdgeInsets.all(this.sz / 3),
          child: ButtonIcon(this.type, this.sz),
        ),
        onPanStart: (_) {
          _send('down&${this.type.toLowerCase()}');
        },
        onPanEnd: (_) {
          _send('up&${this.type.toLowerCase()}');
        },
      )
    );
  }

  void _send(char) {
    print("Sending " + char);
    sock.write('wasd' + '&' + char + '%');
  }
}

void customLayoutLoader(context, layoutName) async{
  globalLayoutName = layoutName;
  globalLayoutButtonList = await getLayoutData(layoutName);
  Navigator.pushNamed(context, '/custom_layout');
}