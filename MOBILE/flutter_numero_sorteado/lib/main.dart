// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:math'; // Importa a biblioteca dart:math para gerar números aleatórios
import 'package:flutter/material.dart'; // Importa o pacote Flutter material

void main() {
  runApp(
      NumeroAleatorioApp()); // Função principal que inicia a aplicação Flutter
}

class NumeroAleatorioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NumeroAleatorio(), // Define o widget principal como NumeroAleatorio
    );
  }
}

class NumeroAleatorio extends StatefulWidget {
  @override
  _NumeroAleatorio createState() =>
      _NumeroAleatorio(); // Cria uma instância do estado mutável _NumeroAleatorio
}

class _NumeroAleatorio extends State<NumeroAleatorio> {
  TextEditingController numeroDigitado =
      TextEditingController(); // Controlador para o campo de texto
  String resultado = ''; // Armazena o resultado da adivinhação
  int maximo = 10; // Intervalo máximo
  int numeroSorteado = Random().nextInt(10)+1; // Armazena o número sorteado
  int minimo = 1; // Intervalo mínimo
  int tentativas = 0; // Conta o número de tentativas
  String maiorMenor = '';

  void _verificar(String operacao) {
    int palpite = int.tryParse(numeroDigitado.text) ??
        0; // Converte o texto digitado para um número inteiro

    setState(() {
      tentativas++; // Incrementa o número de tentativas
      // Verifica se o numero sorteado é maior ou menor que o numero digitado
      if (palpite < numeroSorteado) {
        maiorMenor = 'maior';
      } else if (palpite > numeroSorteado) {
        maiorMenor = 'menor';
      }
      resultado = palpite == numeroSorteado
          ? "Parabéns! Você acertou na tentativa de numero $tentativas!" // Se o palpite for correto
          : "Infelizmente, você errou. O número sorteado era $maiorMenor que o digitado.";
      numeroDigitado.text = ""; // Limpar o campo de texto após a tentativa
    });
  }

  void _sortear(String operacao) {
    setState(() {
      numeroSorteado = Random().nextInt(maximo - minimo + 1) +
          minimo; // Gera um número aleatório dentro do intervalo definido
      resultado = ""; // Limpa o resultado
      tentativas = 0; // Reinicia o número de tentativas
      numeroDigitado.text = ""; // Limpar o campo de texto
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Adivinhação de número Flutter'), // Define o título da barra de aplicativos
      ),
      body: Padding(
        // Widget de preenchimento para dar margem ao redor do conteúdo
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Define o alinhamento principal (vertical) do Column como centralizado
          mainAxisAlignment: MainAxisAlignment
              .center, // Define o alinhamento secundário (horizontal) do Column para esticar os filhos horizontalmente
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Lista de widgets filhos do Column
          children: [
            TextField(
              controller: numeroDigitado, // Controlador para o campo de texto
              keyboardType:
                  TextInputType.number, // Define o tipo de teclado como número
              decoration: InputDecoration(
                  labelText:
                      'Tente adivinhar um numero entre $minimo e $maximo.'), // Define o rótulo do campo de texto
            ),
            SizedBox(
                height:
                    16.0), // Espaçamento vertical entre o campo de texto e os botões
            Row(
              // Widget de linha para alinhar os botões horizontalmente
              mainAxisAlignment:
                  MainAxisAlignment.center, // Alinha os filhos centralmente
              children: [
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _verificar('Verificar'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 184, 255, 232)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle, // Ícone Check
                        size: 25, // Tamanho do ícone
                        color: Colors.green, // Cor do ícone
                      ),
                      SizedBox(width: 8), // Espaçamento entre o ícone e o texto
                      Text('Verificar'),
                    ],
                  ),
                ),

                SizedBox(
                    width:
                        16.0), // Espaçamento horizontal entre o campo de texto e os botões
                ElevatedButton(
                  onPressed: () => _sortear('Sortear'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 167, 217, 255)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shuffle, // Ícone Random
                        size: 25, // Tamanho do ícone
                        color: Colors.blue, // Cor do ícone
                      ),
                      SizedBox(width: 8), // Espaçamento entre o ícone e o texto
                      Text('Sortear'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
                height:
                    16.0), // Espaçamento vertical entre os botões e o resultado
            Text(resultado,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight:
                        FontWeight.bold)), // Exibe o resultado da adivinhação
          ],
        ),
      ),
    );
  }
}
