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
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/layout_select': (context) => LayoutSelect(),
        '/ping_test': (context) => PingTest(),
        '/wasd_layout': (context) => WasdLayout(),
      },
    );
  }
}

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

class LayoutSelect extends StatelessWidget {
  final TextEditingController ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Layout"),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/ping_test');
                      },
                      child: Text('Ping Test'),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/wasd_layout');
                      },
                      child: Text('WASD Layout'),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class PingTest extends StatefulWidget {
  @override
  _PingTestState createState() => _PingTestState();
}

class _PingTestState extends State<PingTest> {
  TextEditingController _controller = TextEditingController();
  Stopwatch stopwatch = new Stopwatch();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ping Test"),
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
                      ? '${String.fromCharCodes(snapshot.data)}' +
                          '\n' +
                          'Latency is ' +
                          '${stopwatch.elapsedMilliseconds}' +
                          ' ms'
                      : ''),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
      sock.write("ping&"+_controller.text+"%");
    }
  }

  @override
  void dispose() {
    print("A");
    super.dispose();
    print("Disposed");
  }
}

class WasdLayout extends StatefulWidget {
  @override
  _WasdLayoutState createState() => _WasdLayoutState();
}

class _WasdLayoutState extends State<WasdLayout> {
  TextEditingController _controller = TextEditingController();
  Stopwatch stopwatch = new Stopwatch();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WASD"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: <Widget>[
            Center(
              
            ),
            Center(
              child:GestureDetector(
                onTapDown: (_) {
                   _send('down&w');
                },
                onTapUp: (_) {
                   _send('up&w');
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(30.0),
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            Center(
              
            ),
            Center(
              child:GestureDetector(
                onTapDown: (_) {
                   _send('down&a');
                },
                onTapUp: (_) {
                   _send('up&a');
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(30.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            Center(
              child:GestureDetector(
                onTapDown: (_) {
                   _send('down&s');
                },
                onTapUp: (_) {
                   _send('up&s');
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(30.0),
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            Center(
              child:GestureDetector(
                onTapDown: (_) {
                   _send('down&d');
                }, 
                onTapUp: (_) {
                   _send('up&d');
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(30.0),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: sock,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData
                      ?   'Latency is ' +
                          '${stopwatch.elapsedMilliseconds}' +
                          ' ms'
                      : ''),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _send(char) {
    print("Sending " + char);
    stopwatch.reset();
    stopwatch.start();
    sock.write('wasd'+'&'+char+'%');
  }

  @override
  void dispose() {
    print("A");
    super.dispose();
    print("Disposed");
  }
}
