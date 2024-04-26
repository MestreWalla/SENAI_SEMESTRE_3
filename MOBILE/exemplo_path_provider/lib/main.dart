import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salvar arquivo localmente'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Directory directory = await getApplicationDocumentsDirectory();
            File file = File('${directory.path}/meu_arquivo.txt');
            await file.writeAsString('Conteúdo do meu arquivo.');
            if (kDebugMode) {
              print('Arquivo salvo em: ${file.path}');
            }
          },
          child: const Text('Salvar arquivo'),
        ),
      ),
    );
  }
}
