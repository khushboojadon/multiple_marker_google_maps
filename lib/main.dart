import 'package:flutter/material.dart';
import 'package:multiple_marker_google_maps/UI/points_map.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PointsonMap(),
    );
  }
}

