import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio 04 e 05',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    InicioPage(),
    ContactPage(),
    ConfiguracoesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Verifica se a largura da tela é maior que um certo threshold para desktops
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercicio 04 e 05'),
      ),
      // Corpo do aplicativo varia de acordo com o item selecionado
      body: _widgetOptions.elementAt(_selectedIndex),
      // BottomNavigationBar somente para dispositivos móveis
      bottomNavigationBar: isDesktop
          ? null
          : BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Início',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contact_page),
                  label: 'Contato',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Configurações',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
            ),
      // Drawer condicional para dispositivos desktop
      drawer: isDesktop
          ? Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Text("Menu"),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Início"),
                    onTap: () => _onItemTapped(0),
                  ),
                  ListTile(
                    leading: Icon(Icons.contact_page),
                    title: Text("Contato"),
                    onTap: () => _onItemTapped(1),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Configurações"),
                    onTap: () => _onItemTapped(2),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.home,
            size: 100,
            color: Colors.red,
          ),
          SizedBox(height: 5),
          Image.asset('../lib/assets/senai.png', width: 150),
          SizedBox(height: 5),
          Text(
            'Página Início do exercício 04',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    // Dynamic textSize based on screen width
    double textSize = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        // Adjustments might be necessary based on your layout
        title: Text('Entre em contato'),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: textSize,
        ),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.8,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Mensagem',
                ),
                maxLines: 4,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  // Lógica para enviar o formulário
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfiguracoesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Painel de Configurações',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
