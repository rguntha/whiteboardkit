import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WhiteboardStyle {
  final Decoration decoration;
  final Color toolboxColor;

  const WhiteboardStyle({this.decoration = const BoxDecoration(
  border: Border.fromBorderSide(BorderSide(width: 1.0, color: Colors.transparent)),
  ), this.toolboxColor = Colors.black38});
}
