import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';

Socket sock;
void main() async {
  // modify with your true address/port
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = 'AIO PC Controller';
    return MaterialApp(
      initialRoute: '/',
      routes:{
        '/': (context) => HomeScreen(),
        '/layout_select': (context) => MyHomePage( title: title,),
      },
    );
  }
}


class HomeScreen extends StatelessWidget{
  final TextEditingController ipController = TextEditingController();

  @override
  Widget build(BuildContext context){
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
                decoration: InputDecoration(labelText: 'Enter the IP address of your PC'),
              ),
              RaisedButton(
                onPressed: (){
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

  void _connectIP(context) async{
    if(ipController.text.isNotEmpty){
      String address = '${ipController.text}';
      sock = await Socket.connect(address, 4444);
      Navigator.pushNamed(context, '/layout_select');
    }
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, @required this.title})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  Stopwatch stopwatch = new Stopwatch();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: sock,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData
                      ? '${String.fromCharCodes(snapshot.data)}'+'\n'+'Latency is '+'${stopwatch.elapsedMilliseconds}'+' ms'
                      : ''),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _sendMessage();

        },
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      print("Sending message");
      stopwatch.reset();
      stopwatch.start();
      sock.write(_controller.text);
    }
  }

  @override
  void dispose() {
    print("A");
    super.dispose();
    print("Disposed");
  }
}