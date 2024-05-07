import 'package:flutter/material.dart';
import 'package:projeto_json/cadastro_carro_view.dart';
import 'package:projeto_json/home_screen_view.dart';
import 'package:projeto_json/listar_carros_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Loja Carros",
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const HomeScreenPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomeScreenPage(),
        '/listar': (context) =>
            const CarrosListarScreen(),
        '/cadastrar': (context) => const CarroCadastroScreen(),
      },
    );
  }
}
