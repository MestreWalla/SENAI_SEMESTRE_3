import 'package:flutter/material.dart';

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loja de Carros"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/listar'),
                child: const Text("Listar Carros")),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/cadastrar'),
                child: const Text("Cadastrar Carros")),
          ],
        ),
      ),
    );
  }
}
