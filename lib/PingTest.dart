import 'package:flutter/material.dart';
import 'config.dart';

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
      sock.write("ping&" + _controller.text + "%");
    }
  }

  @override
  void dispose() {
    super.dispose();
    print("Disposed");
  }
}
