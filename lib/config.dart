import 'dart:io';
import 'package:flutter/material.dart';

Socket sock;
var sockStream;

Stopwatch pingClock = new Stopwatch();

StreamBuilder pingDisplay(stream) {
  return StreamBuilder(
    stream: stream,
    builder: (context, snapshot) {
      pingClock.stop();
      return Center(
        child: Text(
          snapshot.hasData
              ? ((String.fromCharCodes(snapshot.data) == 'pass')
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
