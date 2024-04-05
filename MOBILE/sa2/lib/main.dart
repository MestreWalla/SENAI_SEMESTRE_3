//Arquivo main.dart

import 'package:flutter/material.dart';
import 'package:sa2/view_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Exemplo SQLLite",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginPage());
  }
}