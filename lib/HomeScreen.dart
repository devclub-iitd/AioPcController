import 'package:flutter/material.dart';
import 'config.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  final TextEditingController ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AIO PC Controller"),
      ),
      body: Padding(
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
              RaisedButton(
                onPressed: () {
                  _connectIP(context);
                },
                child: Text('Connect'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _connectIP(context) async {
    if (ipController.text.isNotEmpty) {
      String address = '${ipController.text}';
      try {
        sock = await Socket.connect(address, 4444);
        Navigator.pushNamed(context, '/layout_select');
      }
      on Exception catch(e){
        print(e);
        Navigator.pushNamed(context, '/');
      }
    }
  }
}




