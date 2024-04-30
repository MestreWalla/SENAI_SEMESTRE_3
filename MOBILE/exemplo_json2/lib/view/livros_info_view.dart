import 'package:exemplo_json2/model/livro_model.dart';
import 'package:flutter/material.dart';

class LivroInfoPage extends StatelessWidget {
  final Livro info;

  const LivroInfoPage({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livro Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(info.titulo),
            Text(info.autor),
            Text(info.sinopse),
            Text(info.categoria),
            Text(info.isbm.toString()),
          ],
        ),
      ),
    );
  }
}
