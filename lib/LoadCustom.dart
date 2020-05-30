import 'package:aio_pc_controller/Custom.dart';
import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
import 'Dialogs.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      rows.add(new Slidable(
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
            title: Text('${tableList[i][0].toUpperCase()}${tableList[i].substring(1)}'),
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LayoutDelete(this, tableList[i]);
                  },
                );
              }),
        ],
      ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Load Custom Layout"),
        ),
        body: ListView(
          children: rows,
        ));
  }
}

void loadCustomBuilder(context) async {
  tableList = await getTables();
  Navigator.pushNamed(context, '/loadcustom');
}

void refresh(context) async {
  Navigator.pop(context);
  loadCustomBuilder(context);
}
