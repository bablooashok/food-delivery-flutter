import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/src/helpers/style.dart';
import 'package:flutter_food_delivery/src/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
        primarySwatch: red,
      ),
      home: LoginScreen(),
    );
  }
}
