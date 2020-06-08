import 'package:aio_pc_controller/Custom.dart';
import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
import 'Dialogs.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'CustomLayout.dart';

List<String> tableList;

class LoadCustom extends StatefulWidget {
  @override
  LoadCustomState createState() => new LoadCustomState();
}

class LoadCustomState extends State<LoadCustom> {
  @override
  Widget build(BuildContext context) {
    List<Widget> rows = new List<Widget>();

    for (var i = 0; i < tableList.length; i++) {
      rows.add(new GestureDetector(
          child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigoAccent,
                child: Text(tableList[i][0].toUpperCase()),
                foregroundColor: Colors.white,
              ),
              title: Text(tableList[i]),
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
                caption: 'Edit',
                color: Colors.blue,
                icon: Icons.create,
                onTap: () {
                  customLoader(context, tableList[i]);
                }),
            IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  deleteTable(tableList[i]);
                  refresh(context);
                }),
            ],
          ),
          onTap: (){
            customLayoutLoader(context, tableList[i]);
          },
        )
      );

      rows.add(new Opacity(
          opacity: 0.3,
          child: Divider(
            height: 2,
            thickness: 1,
            color: Colors.grey,
          )));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Load Custom Layout"),
          bottom: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: Colors.blue,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.blue, 
                              width: 2.0,
                            )
                          )
                        ),
                        child: Center(
                          child: Text(
                            'LAYOUTS',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white54,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/layout_select');
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.blue[700],
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white, 
                              width: 2.0,
                            )
                          )
                        ),
                        child: Center(
                          child: Text(
                            'My LAYOUTS',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                ),
              ],
            ), 
            preferredSize: Size.fromHeight(48.0)
          ),
        ),
        body: ListView(
          children: rows,
        ));
  }
}

void loadCustomBuilder(context) async {
  tableList = await getTables();
  Navigator.pushReplacementNamed(context, '/loadcustom');
}

void refresh(context) async {
  tableList = await getTables();
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => LoadCustom(),
      transitionDuration: Duration(seconds: 0),
    ),
  );
}
