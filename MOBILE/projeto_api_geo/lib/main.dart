import 'package:flutter/material.dart';
import 'package:projeto_api_geo/View/historico_screen.dart';
import 'package:projeto_api_geo/View/home_screen.dart';
import 'package:projeto_api_geo/View/pesquisa_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API GEO',
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/historico': (context) => const HistoricoScreen(),
        '/pesquisa': (context) => const PesquisaScreen(),
      },
    );
  }
}