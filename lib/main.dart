import 'package:flutter/material.dart';
import 'flare_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flare Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 102, 18, 222),
        body: Align(
          alignment: Alignment.bottomCenter,
            child: FlareAnimation(),
        ),
      ),
    );
  }
}


