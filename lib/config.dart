import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';

Socket sock;
var sockStream;
Random statusKeyGenerator = new Random();
int statusKey = 0;

Stopwatch pingClock = new Stopwatch();

void statusCheck() {
  pingClock.reset();
  pingClock.start();
  statusKey = statusKeyGenerator.nextInt(1000);
  var test;
  if (sock == null) return;
  try {
    sock.write('status&' + statusKey.toString() + '%');
    test = sock.address.host;
    test = sock.remotePort;
  } on OSError {
    sock = null;
    return;
  } on SocketException {
    sock = null;
    return;
  } on NoSuchMethodError {
    sock = null;
    return;
  }
}

StreamBuilder pingDisplay(stream) {
  return StreamBuilder(
    stream: stream,
    builder: (context, snapshot) {
      pingClock.stop();
      return Center(
        child: Text(
          snapshot.hasData
              ? ((String.fromCharCodes(snapshot.data) ==
                      'pass' + statusKey.toString())
                  ? '${pingClock.elapsedMilliseconds}' + 'ms'
                  : '')
              : '',
          style: TextStyle(
              color: pingClock.elapsedMilliseconds < 70
                  ? Colors.green
                  : (pingClock.elapsedMilliseconds < 140
                      ? Colors.yellow
                      : Colors.red)),
        ),
      );
    },
  );
}
