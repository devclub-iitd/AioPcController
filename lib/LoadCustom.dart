import 'package:aio_pc_controller/Custom.dart';
import 'package:aio_pc_controller/HomeScreen.dart';
import 'package:aio_pc_controller/LayoutSelect.dart';
import 'package:aio_pc_controller/globals.dart';
import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'CustomLayout.dart';
import 'Theme.dart';

List<String> tableList;

class LoadCustom extends StatefulWidget {
  @override
  LoadCustomState createState() => new LoadCustomState();
}

class LoadCustomState extends State<LoadCustom> {
  @override
  Widget build(BuildContext context) {
    List<Widget> rows = new List<Widget>();

    rows.add(new Material(
      color: currentThemeColors.createBackgroundColor,
      child: InkWell(
        splashColor: currentThemeColors.createSplashColor,
        onTap:(){
          customLoader(context, '_untitled');
        },
        child: Container(
          padding: const EdgeInsets.all(7.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(
                color: currentThemeColors.createBorderColor, 
                width: 5.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            title: Icon(
              Icons.add,
              size: 40.0,
              color: currentThemeColors.createTextColor,
            ),
            subtitle: Center(
              child: Text(
                'Create a custom layout',
                style: TextStyle(
                  color: currentThemeColors.createTextColor,
                  fontSize: 17.0,
                ),
              ),
            ),
          )
        ),
      ),
    ),
    );

    for (var i = 0; i < tableList.length; i++) {
      rows.add(new GestureDetector(
          child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: currentThemeColors.listTileColor,
            child: Container(
              color: currentThemeColors.listTileColor,

            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: currentThemeColors.listIconColor,
                child: Text(tableList[i][0].toUpperCase()),
                foregroundColor: Colors.white,
              ),
              title: Text(tableList[i]),
            )
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
                  loadCustomBuilder(context);
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
          title: Text("My Custom Layouts"),
          bottom: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: currentThemeColors.unselectedTabColor,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: currentThemeColors.unselectedTabBorderColor, 
                              width: 2.0,
                            )
                          )
                        ),
                        child: Center(
                          child: Text(
                            'CONNECT',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white54,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      onTap: (){
                        Navigator.pushReplacement(context, PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => HomeScreen(),
                          transitionDuration: Duration(seconds: 0),
                        ),);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: currentThemeColors.unselectedTabColor,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: currentThemeColors.unselectedTabBorderColor, 
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
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      onTap: (){
                        Navigator.pushReplacement(context, PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => LayoutSelect(),
                          transitionDuration: Duration(seconds: 0),
                        ),);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: currentThemeColors.selectedTabColor,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: currentThemeColors.selectedTabBorderColor, 
                              width: 2.0,
                            )
                          )
                        ),
                        child: Center(
                          child: Text(
                            'CUSTOM',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 16.0,
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
  Navigator.pushReplacement(context, PageRouteBuilder(
    pageBuilder: (context, animation1, animation2) => LoadCustom(),
    transitionDuration: Duration(seconds: 0),
  ),);
}

