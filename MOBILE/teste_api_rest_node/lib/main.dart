import 'package:flutter/material.dart';
import 'package:teste_api_rest_node/screen/cadastrar_produto_screen.dart';
import 'package:teste_api_rest_node/screen/home_screen.dart';
import 'package:teste_api_rest_node/screen/listar_produtos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto Api Rest Json',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/listar':  (context) => const ListarProdutosScreen(),
        '/cadastrar':  (context) => const CadastrarProdutoScreen(),
      },
    );
  }
}
