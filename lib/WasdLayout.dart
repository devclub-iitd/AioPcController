import 'package:flutter/material.dart';
import 'config.dart';

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
