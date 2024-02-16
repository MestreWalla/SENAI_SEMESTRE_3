import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(NumeroAleatorioApp());
}

class NumeroAleatorioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NumeroAleatorio(),
    );
  }
}

class NumeroAleatorio extends StatefulWidget {
  @override
  _NumeroAleatorio createState() => _NumeroAleatorio();
}

class _NumeroAleatorio extends State<NumeroAleatorio> {
  TextEditingController _NumeroDigitado = TextEditingController();
  String _resultado = '';
  int numeroSorteado = 0;
  int minimo = 1; // Intervalo mínimo
  int maximo = 10; // Intervalo máximo


  void _sortear(String operacao) {
    int palpite = int.tryParse(_NumeroDigitado.text) ?? 0;

    setState(() {
      numeroSorteado = Random().nextInt(maximo - minimo + 1) + minimo;
      _resultado = palpite == numeroSorteado
          ? "Parabéns! Você acertou!"
          : "Infelizmente, você errou. O número sorteado era $numeroSorteado.";
      _NumeroDigitado.text = ""; // Limpa o campo de texto após a tentativa
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora Flutter'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _NumeroDigitado,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Digite o numero que voce acha que é'),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () => _sortear('Sortear'),
                      child: Text('Sortear'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 139, 164, 254)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(_resultado,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ],
            )));
  }
}
