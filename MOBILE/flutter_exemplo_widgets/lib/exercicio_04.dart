// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicios de Material',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Ajuste para o tema primarySwatch
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
  double _progressValue = 0.0; // Variável para controlar o progresso

  static List<Widget> _widgetOptions = <Widget>[
    InicioPage(),
    // ContactPage(),
    StorePage(),
    ConfiguracoesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Inicia o temporizador para simular o progresso
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_progressValue < 1.0) {
          _progressValue += 0.1; // Incrementa o valor do progresso
        } else {
          timer
              .cancel(); // Cancela o temporizador quando o progresso atinge 100%
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Verifica se a largura da tela é maior que um certo threshold para desktops
    bool isTablet = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercicios de Material'),
        backgroundColor: Colors.blue.withOpacity(0.5),
      ),
      body: Stack(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
          // Barra de progresso
          _progressValue < 1.0
              ? LinearProgressIndicator(
                  value: _progressValue,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : Container(), // Se o progresso for completo, esconde a barra de progresso
        ],
      ),
      // BottomNavigationBar somente para dispositivos móveis
      bottomNavigationBar: isTablet
          ? null
          : BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Início',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.store),
                  label: 'Loja',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Configurações',
                ),
              ],
              currentIndex: _selectedIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
            ),
      // Drawer para tablet
      drawer: isTablet
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
                    leading: Icon(Icons.shop),
                    title: Text("Loja"),
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
    return Stack(
      children: <Widget>[
        // Imagem de fundo
        Image.asset(
          '../lib/assets/wallpaper.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        // Texto sobreposto
        Positioned(
          top: 20.0,
          left: 20.0,
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.black.withOpacity(0.5),
            child: Text(
              'Página Início',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ],
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
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Center(
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
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para salvar as configurações do perfil
                  },
                  child: Text(
                    'Enviar',
                    style: TextStyle(
                      color: Colors.blue, // Defina a cor do texto como azul
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConfiguracoesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox.shrink(), // Define o título da AppBar como vazio
          toolbarHeight:0, // Define a altura da AppBar manualmente
          bottom: TabBar(
            tabs: [
              Tab(text: 'Perfil'),
              Tab(text: 'Pagamento'),
              Tab(text: 'Aplicativo'),
              Tab(text: 'Suporte'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPerfilTabContent(),
            _buildTabContent('Configurações do Pagamento'),
            SingleChildScrollView(
              // Adicionando SingleChildScrollView aqui
              child: _buildConfiguracoesDoAplicativo(context),
            ),
            ContactPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildPerfilTabContent() {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: 400), // Define o máximo de largura
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Configurações do Perfil',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                // Centralizar a foto de perfil
                GestureDetector(
                  onTap: () {
                    // Adicione aqui a lógica para selecionar uma imagem da galeria
                  },
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      //backgroundImage: AssetImage('caminho/para/imagem_padrao.jpg'),
                      child: Icon(Icons.person, size: 80, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Sobrenome',
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
                    labelText: 'Telefone',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Endereço',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para salvar as configurações do perfil
                  },
                  child: Text(
                    'Salvar',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildConfiguracoesDoAplicativo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Configurações do Aplicativo',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Idioma'),
            subtitle: Text('Português'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Lógica para alterar o idioma
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Tema'),
            subtitle: Text('Escuro'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Lógica para alterar o tema
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificações'),
            subtitle: Text('Ativado'),
            trailing: Switch(
              value: false,
              onChanged: (value) {
                // Lógica para ligar/desligar notificações
              },
              activeColor: Colors.green.withOpacity(
                  0.5), // Define a cor de fundo do botão switch quando ativado
              activeTrackColor:
                  Colors.blue, // Define a cor de fundo da faixa quando ativado
              inactiveThumbColor: Colors
                  .white, // Define a cor da bolinha central quando desativado
              inactiveTrackColor: Colors.blue.withOpacity(
                  0.5), // Define a cor de fundo da faixa quando desativado
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.backup),
            title: Text('Backup'),
            subtitle: Text('Agendado para hoje'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Lógica para configurar o backup
            },
          ),
        ],
      ),
    );
  }
}

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox.shrink(), // Define o título da AppBar como vazio
          toolbarHeight:0, // Define a altura da AppBar manualmente
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          _buildProductCard(
            imageUrl: '../lib/assets/product.webp',
            title: 'Produto 1',
            description: 'Descrição do Produto 1',
          ),
          SizedBox(height: 16.0),
          _buildProductCard(
            imageUrl: '../lib/assets/product.webp',
            title: 'Produto 2',
            description: 'Descrição do Produto 2',
          ),
          SizedBox(height: 16.0),
          _buildProductCard(
            imageUrl: '../lib/assets/product.webp',
            title: 'Produto 3',
            description: 'Descrição do Produto 3',
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
      {required String imageUrl,
      required String title,
      required String description}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                ButtonBar(
                  children: <Widget>[
                    TextButton(
                      child: Text(
                        'DETALHES',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: Icon(
                        Icons.share,
                        size: 25,
                        color: Colors.blue,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}