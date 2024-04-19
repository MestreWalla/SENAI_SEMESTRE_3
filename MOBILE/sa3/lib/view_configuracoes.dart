// ignore_for_file: no_logic_in_create_state, library_private_types_in_public_api, use_key_in_widget_constructors, use_build_context_synchronously
// arquivo view_configuracoes
import 'package:flutter/material.dart';
import 'package:sa3/controller_database.dart';
import 'package:sa3/view_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  //atributo
  final String email;

  const ConfiguracoesPage({required this.email});

  @override
  _ConfiguracoesPageState createState() =>
      _ConfiguracoesPageState(email: email);
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  //Atributos
  late SharedPreferences _prefs;
  bool _darkMode = false;
  final String email;
  String _idioma = 'pt-br';

  _ConfiguracoesPageState({required this.email});

  //Métodos
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = _prefs.getBool('${email}darkMode') ?? false;
      _idioma = _prefs.getString('${email}SelIdioma') ?? 'pt-br';
    });
  }

  Future<void> _mudarDarkMode() async {
    setState(() {
      _darkMode = !_darkMode;
    });
    await _prefs.setBool('${email}darkMode', _darkMode);
  }

  Future<void> _mudarIdioma(String novoIdioma) async {
    setState(() {
      _idioma = novoIdioma;
    });

    // Salvar o novo idioma nas preferências
    await _prefs.setString('${email}SelIdioma', _idioma);
  }

  Future<void> _fazerLogoff() async {
  await AuthController.fazerLogoff();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}


  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _darkMode
          ? ThemeData.dark()
          : ThemeData.light(), // Define o tema com base no modo escuro
      duration:
          const Duration(milliseconds: 500), // Define a duração da transição
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _idioma == 'pt-br'
                ? 'Teste de Armazenamento Interno'
                : _idioma == 'en-us'
                    ? 'Internal Storage Test'
                    : _idioma == 'es-ar'
                        ? 'Prueba de Almacenamiento Interno'
                        : '',
          ),
          actions: [
            IconButton(
              onPressed: () {
                _fazerLogoff();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              // Exibe o texto de acordo com o idioma selecionado
              Text(
                _idioma == 'pt-br'
                    ? 'Selecione o Modo Escuro'
                    : _idioma == 'en-us'
                        ? 'Select Dark Mode'
                        : _idioma == 'es-ar'
                            ? 'Seleccione el Modo Oscuro'
                            : '',
              ),
              Switch(
                value: _darkMode,
                onChanged: (value) {
                  _mudarDarkMode();
                },
              ),
              Text(
                _idioma == 'pt-br'
                    ? 'Selecione o Idioma'
                    : _idioma == 'en-us'
                        ? 'Select Language'
                        : _idioma == 'es-ar'
                            ? 'Seleccione el Idioma'
                            : '',
              ),
              DropdownButton<String>(
                value: _idioma,
                onChanged: (value) {
                  _mudarIdioma(value!);
                },
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    value: 'pt-br',
                    child: Text('Português (Brasil)'),
                  ),
                  DropdownMenuItem(
                    value: 'en-us',
                    child: Text('Inglês (EUA)'),
                  ),
                  DropdownMenuItem(
                    value: 'es-ar',
                    child: Text('Espanhol (Argentina)'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
