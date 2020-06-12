import 'package:aio_pc_controller/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config.dart';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'globals.dart';
import 'Theme.dart';
import 'LayoutSelect.dart';
import 'dart:convert';
import 'LoadCustom.dart';
import 'dart:typed_data';

class HomeScreen extends StatefulWidget{
  

  @override 
  HomeScreenState createState() => new HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  final TextEditingController ipController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  String status;
  
  @override
  Widget build(BuildContext context) {
    if (sock == null) {
      status = 'null';
    } else {
      bool open = true;
      var test;
      try{
        sock.write('status&test%');
        test = sock.address.host;
        test = sock.remotePort;
        if(open) status = 'connected';
      }
      on OSError{
        sock = null;
        status = 'null';
        open = false;
      }
      on SocketException{
        sock = null;
        status = 'null';
        open = false;
      }
    }
    print(status);
    return Scaffold(
      appBar: AppBar(
        title: Text("AIO PC Controller"),
        bottom: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: currentThemeColors.tabColor,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: currentThemeColors.selectedTabBorderColor,
                          width: 2.0,
                        ))),
                        child: Center(
                          child: Text(
                            'CONNECT',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: currentThemeColors.tabColor,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: currentThemeColors.unselectedTabBorderColor,
                          width: 2.0,
                        ))),
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
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                LayoutSelect(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: currentThemeColors.tabColor,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: currentThemeColors.unselectedTabBorderColor,
                          width: 2.0,
                        ))),
                        child: Center(
                          child: Text(
                            'CUSTOM',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white54,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        loadCustomBuilder(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(48.0)),
      ),
      body: SingleChildScrollView(
        child: status == 'connected'
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  Center(
                      child: Text(
                    ("You are connected."),
                    style: TextStyle(color: Colors.green),
                  )),
                  Center(child: Text(
                    ("IP Address: " + "${sock.address.host}"),
                    style: TextStyle(color: Colors.green),)),
                    Center(child: Text(
                    ("Port: " + "${sock.remotePort}"),
                    style: TextStyle(color: Colors.green),)),
                    
            StreamBuilder(
              stream: sockStream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData
                      ? ((String.fromCharCodes(snapshot.data)=='pass')?'Server is responding well!':'Server is responding.. but there might be some error')
                      : 'Server is not responding.. You need to re-establish connection.'),
                );
              },
            ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RaisedButton(
                        color: currentThemeColors.accentColor,
                        textColor: Colors.white,
                        onPressed: () {
                          sock.write('disconnect%');
                          sock.destroy();
                          sock = null;
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  HomeScreen(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                        child: Text('Disconnect'),
                      ),
                    ),
                  ),
                ]),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: ipController,
                        decoration: InputDecoration(
                            labelText: 'Enter the IP address of your PC'),
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: portController,
                        decoration: InputDecoration(labelText: 'Enter Port'),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RaisedButton(
                            color: currentThemeColors.accentColor,
                            textColor: Colors.white,
                            onPressed: () {
                              _connectIP_Form(context);
                            },
                            child: Text('Connect'),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RaisedButton(
                            color: currentThemeColors.accentColor,
                            textColor: Colors.white,
                            onPressed: () {
                              _connectIP_QRcode(context);
                            },
                            child: Text('Scan'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _connectIP_Form(context) async {
    if (ipController.text.isNotEmpty && portController.text.isNotEmpty) {
      String address = '${ipController.text}';
      int port = int.parse(portController.text);
      print('port: ' + port.toString());
      try {
        sock = await Socket.connect(address, port);
        sockStream = sock.asBroadcastStream();
        print(sock.address);
        Navigator.pushReplacementNamed(context, '/layout_select');
      } on Exception catch (e) {
        print(e);
        sock = null;
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }

  void _connectIP_QRcode(context) async {
    var qrscan = await BarcodeScanner.scan();
    String result = qrscan.rawContent;
    if (result != '') {
      var address = result.split(':');
      if (address.length == 2) {
        try {
          int port = int.parse(address[1]);
          try {
            sock = await Socket.connect(address[0], port);
            sockStream = sock.asBroadcastStream();
            Navigator.pushReplacementNamed(context, '/layout_select');
          } on Exception catch (e) {
            print(e);
            Navigator.pushReplacementNamed(context, '/');
          }
        } on FormatException {
          Navigator.pushReplacementNamed(context, '/');
        }
      } else {
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
