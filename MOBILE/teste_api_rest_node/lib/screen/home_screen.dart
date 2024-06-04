import 'package:flutter/material.dart';
import 'package:teste_api_rest_node/screen/cadastrar_produto_screen.dart';
import 'package:teste_api_rest_node/screen/listar_produtos_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add a bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Listar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Cadastrar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      // Main content of the screen
      body: IndexedStack(
        index: _selectedIndex,
        children: const <Widget>[
          // Replace this with your 'Listar' page
          ListarProdutosScreen(),
          // Replace this with your 'Cadastrar' page
          CadastrarProdutoScreen(),
        ],
      ),
    );
  }
}