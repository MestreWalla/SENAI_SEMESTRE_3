import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  TextEditingController _controllerNumero1 = TextEditingController();
  TextEditingController _controllerNumero2 = TextEditingController();
  String _resultado = '';

  void _calcular(String operacao) {
    double numero1 = double.tryParse(_controllerNumero1.text) ?? 0.0;
    double numero2 = double.tryParse(_controllerNumero2.text) ?? 0.0;
    double resultado;

    setState(() {
      //Montar as operações
      if (operacao == "Somar") {
        resultado = numero1 + numero2;
      } else if (operacao == "Subtracao") {
        resultado = numero1 - numero2;
      } else if (operacao == "Divisao") {
        resultado = numero2 != 0 ? numero1 / numero2;
      } else {
        resultado = numero1 * numero2;
      }
      _resultado = 'o resultado é $resultado';
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
              controller: _controllerNumero1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número 1'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controllerNumero2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número 2'),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _calcular('Somar'),
                  child: Text('Somar'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 139, 164, 254)),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _calcular('Subtracao'),
                  child: Text('Subtração'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 254, 147, 139)),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _calcular('Divisao'),
                  child: Text('Divisão'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 254, 219, 139)),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _calcular('Multiplicacao'),
                  child: Text('Multiplicação'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 139, 254, 206)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(_resultado,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
