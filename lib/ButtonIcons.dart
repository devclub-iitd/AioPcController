import 'package:flutter/material.dart';

Widget ButtonIcon(String type, double sz) {
  if (type.length == 1) {
    return Center(
        child: Text(
      type,
      style: TextStyle(fontSize: sz / 3, color: Colors.white),
    ));
  }
  if (type == 'space')
    return Icon(
      Icons.space_bar,
      color: Colors.white,
      size: (sz) / 3,
    );
  if (type == 'shift')
    return Icon(
      Icons.keyboard_capslock,
      color: Colors.white,
      size: (sz) / 3,
    );
}
