import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChartData {
  String year;
  String name;
  double value;
  Color colorVal = Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
      .withOpacity(1.0);
}