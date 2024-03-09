// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// Importa o pacote material.dart do Flutter
import 'package:flutter/material.dart';

// Função principal do aplicativo
void main() {
  // Executa a função runApp com a classe MyApp como argumento
  runApp(MyApp());
}

// Classe MyApp que herda de StatelessWidget
class MyApp extends StatelessWidget {
  // Sobrescreve o método build da classe pai
  @override
  Widget build(BuildContext context) {
    // Retorna um widget MaterialApp
    return MaterialApp(
      // Define o título do aplicativo
      title: 'Exercicio 02',
      // Define o widget filho como um Scaffold
      home: Scaffold(
        // Define a barra de app como um AppBar
        appBar: AppBar(
          // Define o título da barra de app
          title: Text('Exercicio 02'),
        ),
        // Define o corpo da tela como um Center
        body: Center(
          // Define o filho do Center como um Column
          child: Column(
            // Define o alinhamento principal da coluna como central
            mainAxisAlignment: MainAxisAlignment.center,
            // Define os widgets filhos da coluna
            children: <Widget>[
              // Container verde com texto
              Container(
                // Define a altura do container
                height: 50,
                // Define as margens do container
                margin: EdgeInsets.all(5),
                // Define o preenchimento do container
                padding: EdgeInsets.all(10),
                // Define a cor do container
                color: Colors.green,
                // Define o filho do container como um Center
                child: Center(
                  // Define o filho do Center como um Text
                  child: Text(
                    // Define o texto dentro do Text
                    'Organização com Row e Column:',
                    // Define o estilo do texto
                    style: TextStyle(
                      // Define a cor do texto
                      color: Color.fromARGB(255, 201, 255, 205),
                      // Define o tamanho da fonte do texto
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // Container azul com texto
              Container(
                // Define a altura do container (opcional)
                height: 100,
                // Define as margens do container
                margin: EdgeInsets.all(5),
                // Define o preenchimento do container
                padding: EdgeInsets.all(10),
                // Define a cor do container
                color: Colors.blue,
                // Define o filho do container como um Center
                child: Center(
                  // Define o filho do Center como um Text
                  child: Text(
                    // Define o texto dentro do Text
                    'Desenvolva uma interface que faça uso dos widgets Row e Column para organizar elementos de forma horizontal e vertical. Adicione diversos widgets (como Text, Icon e Image) para demonstrar a organização.',
                    // Define o estilo do texto
                    style: TextStyle(
                      // Define a cor do texto
                      color: Color.fromARGB(255, 217, 227, 255),
                      // Define o tamanho da fonte do texto
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // Espaço vertical de 20 pixels
              SizedBox(height: 20),
              // Row com ícones
              Row(
                // Define o alinhamento principal da linha como central
                mainAxisAlignment: MainAxisAlignment.center,
                // Define os widgets filhos da linha
                children: <Widget>[
                  // Ícone de mais opções verticais
                  Icon(Icons.more_vert, size: 50, color: Colors.yellow),
                  // Ícone de indicador de arrasto
                  Icon(Icons.drag_indicator, size: 50, color: Colors.yellow),
                  // Ícone de aplicativos
                  Icon(Icons.apps, size: 50, color: Colors.yellow),
                ],
              ),
              // Espaço vertical de 20 pixels
              SizedBox(height: 20),
              // Coluna com imagem e texto
              Column(
                // Define os widgets filhos da coluna
                children: <Widget>[
                  // Imagem do SENAI (primeira imagem)
                  Image.asset('../lib/assets/senai.png',
                    width: 150,
                  ),
                  // Texto SENAI
                  Text('SENAI',
                    // Define o estilo do texto
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.red,
                    ),
                  ),
                  // Imagem do SENAI (segunda imagem)
                  Image.asset('../lib/assets/senai.png',
                    width: 150,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
