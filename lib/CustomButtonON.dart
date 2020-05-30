import 'package:flutter/material.dart';
import 'Custom.dart';
class CustomButtonON{
  final int id;
  final String layoutId, type;
  final double x,y,sz;
  CustomButtonON({this.id, this.layoutId, this.type, this.x, this.y, this.sz});
  Map<String, dynamic> toMap() {
    return {'id': id, 'layoutId': layoutId, 'type': type, 'x': x, 'y':y, 'sz':sz};
  }
}