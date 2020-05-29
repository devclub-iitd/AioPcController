import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';

List<String> tableList;
class LoadCustom extends StatefulWidget{
  @override
  LoadCustomState createState() => new LoadCustomState();
}

class LoadCustomState extends State<LoadCustom> {

  @override
  Widget build(BuildContext context) {

    List<Widget> rows = new List<Widget>();
    for(var i = 0; i < tableList.length; i++){
        rows.add(new Card(
          child: ListTile(
              title: Text(tableList[i]),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  
                }
              ),
            )
          )
        );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Load Custom Layout"),
        ),
        body: ListView(
          children: rows,
        )
    );
  }
}

void loadCustomBuilder(context) async{
  tableList = await getTables();
  Navigator.pushNamed(context, '/loadcustom');
}
