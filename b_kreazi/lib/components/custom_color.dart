import 'package:flutter/material.dart';

MaterialColor myCustomColor({int red=250, int green=193, int blue=60}) {
  return MaterialColor(Color.fromRGBO(red, green, blue, 1).value, {
    50: Color.fromRGBO(red, green, blue, 0.1),
    100: Color.fromRGBO(red, green, blue, 0.2),
    200: Color.fromRGBO(red, green, blue, 0.3),
    300: Color.fromRGBO(red, green, blue, 0.4),
    400: Color.fromRGBO(red, green, blue, 0.5),
    500: Color.fromRGBO(red, green, blue, 0.6),  // floating action button, radio, checkbox
    600: Color.fromRGBO(red, green, blue, 0.7),
    700: Color.fromRGBO(red, green, blue, 0.8),
    800: Color.fromRGBO(red, green, blue, 0.9),
    900: Color.fromRGBO(red, green, blue, 1),
  });
}

Color myCustomLighterColor({int red=255, int green=240, int blue=211}) {
  return MaterialColor(Color.fromRGBO(red, green, blue, 1).value, {
    50: Color.fromRGBO(red, green, blue, 0.1),
    100: Color.fromRGBO(red, green, blue, 0.2),
    200: Color.fromRGBO(red, green, blue, 0.3),
    300: Color.fromRGBO(red, green, blue, 0.4),
    400: Color.fromRGBO(red, green, blue, 0.5),
    500: Color.fromRGBO(red, green, blue, 0.6),  // floating action button, radio, checkbox
    600: Color.fromRGBO(red, green, blue, 0.7),
    700: Color.fromRGBO(red, green, blue, 0.8),
    800: Color.fromRGBO(red, green, blue, 0.9),
    900: Color.fromRGBO(red, green, blue, 1),
  });
}

Color myCustomDarkerColor({int red=215, int green=122, int blue=0}) {
  return MaterialColor(Color.fromRGBO(red, green, blue, 1).value, {
    50: Color.fromRGBO(red, green, blue, 0.1),
    100: Color.fromRGBO(red, green, blue, 0.2),
    200: Color.fromRGBO(red, green, blue, 0.3),
    300: Color.fromRGBO(red, green, blue, 0.4),
    400: Color.fromRGBO(red, green, blue, 0.5),
    500: Color.fromRGBO(red, green, blue, 0.6),  // floating action button, radio, checkbox
    600: Color.fromRGBO(red, green, blue, 0.7),
    700: Color.fromRGBO(red, green, blue, 0.8),
    800: Color.fromRGBO(red, green, blue, 0.9),
    900: Color.fromRGBO(red, green, blue, 1),
  });
}