import 'package:flutter/material.dart';

List<Color> generateColors(int count) {
  List<Color> colors = [];
  for (var i = 0; i < count; i++) {
    final hue = 360 * i / count;
    colors.add(HSLColor.fromAHSL(1.0, hue, 0.5, 0.5).toColor());
  }
  return colors;
}