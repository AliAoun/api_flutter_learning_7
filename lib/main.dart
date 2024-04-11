import 'package:api_flutter_learning_7/DropdownTest.dart';
import 'package:api_flutter_learning_7/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Learning Api",
      theme: ThemeData.dark(),
      home: DropDownTesting(),
    );
  }
}