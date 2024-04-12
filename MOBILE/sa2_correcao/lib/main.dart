// Arquivo main.dart
import 'package:flutter/material.dart';
import 'package:sa2_correcao/view_login.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SA2",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
