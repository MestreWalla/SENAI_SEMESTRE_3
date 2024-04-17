// Arquivo main.dart
import 'package:flutter/material.dart';
import 'package:sa3/view_login.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SA3",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
