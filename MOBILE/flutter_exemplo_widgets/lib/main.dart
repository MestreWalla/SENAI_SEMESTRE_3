// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exemplo de Árvore de Widgets'),
        ),
        body: Column(
          children: [
            Text('Primeiro Filho'),
            Container(
              color: Color.fromARGB(255, 182, 182, 182),
              child: Row(
                children: [
                  Column(
                    children: const [
                      Text('Filho Aninhado 1'),
                    ],
                  ),
                  Column(
                    children: const [
                      Text('Filho Aninhado 2'),
                    ],
                  ),
                ],
              ),
            ),
            Text('Segundo Filho'),
          ],
        ),
      ),
    );
  }
}
