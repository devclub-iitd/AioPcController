import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  final TextEditingController ipController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AIO PC Controller"),
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: ipController,
                  decoration: InputDecoration(
                      labelText: 'Enter the IP address of your PC'),
                ),
                TextFormField(
                  controller: portController,
                  decoration: InputDecoration(
                      labelText: 'Enter Port'
                      ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RaisedButton(
                      onPressed: () {
                        _connectIP(context);
                      },
                      child: Text('Connect'),
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

  void _connectIP(context) async {
    if (ipController.text.isNotEmpty && portController.text.isNotEmpty) {
      String address = '${ipController.text}';
      int port = int.parse(portController.text);
      try {
        sock = await Socket.connect(address, port);
        Navigator.pushNamed(context, '/layout_select');
      }
      on Exception catch(e){
        print(e);
        Navigator.pushNamed(context, '/');
      }
    }
  }
}




