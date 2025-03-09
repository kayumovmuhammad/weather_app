import 'package:flutter/material.dart';
import 'package:weather_app/pages/home.dart';

void main() {
    // hello hello hello
    runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
    },
  ));
}
