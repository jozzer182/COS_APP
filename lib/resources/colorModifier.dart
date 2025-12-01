// Función para hacer más claro un color en un porcentaje dado
import 'package:flutter/material.dart';

Color lightenColor(Color color, double factor) {
  assert(factor >= 0 && factor <= 1);

  int red = (color.red + ((255 - color.red) * factor)).round();
  int green = (color.green + ((255 - color.green) * factor)).round();
  int blue = (color.blue + ((255 - color.blue) * factor)).round();

  return Color.fromARGB(color.alpha, red, green, blue);
}

// Función para hacer más oscuro un color en un porcentaje dado
Color darkenColor(Color color, double factor) {
  assert(factor >= 0 && factor <= 1);

  int red = (color.red - (color.red * factor)).round();
  int green = (color.green - (color.green * factor)).round();
  int blue = (color.blue - (color.blue * factor)).round();

  return Color.fromARGB(color.alpha, red, green, blue);
}
