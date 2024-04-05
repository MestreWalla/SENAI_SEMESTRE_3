//Arquivo bottonappbar.dart

import 'package:flutter/material.dart';

class BottomAppBarDemo extends StatelessWidget {
  const BottomAppBarDemo({super.key});

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Bottom App Bar'),
        ),
        body: const Center(
        child: Text('Hello, world!'),
        ),
        bottomNavigationBar: BottomAppBar(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
            IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                );
                },
            ),
            IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewCadastros()),
                );
                },
            ),
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewConfiguracoes()),
                );
                },
            ),
            ],
        ),
        ),
    );
    }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Home Page'),
        ),
        body: const Center(
        child: Text('Welcome to the home page!'),
        ),
    );
    }
}

class ViewCadastros extends StatelessWidget {
  const ViewCadastros({super.key});

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Cadastros'),
        ),
        body: const Center(
        child: Text('Aqui você pode gerenciar seus cadastros.'),
        ),
    );
    }
}

class ViewConfiguracoes extends StatelessWidget {
  const ViewConfiguracoes({super.key});

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Configurações'),
        ),
        body: const Center(
        child: Text('Aqui você pode configurar o aplicativo.'),
        ),
    );
    }
}