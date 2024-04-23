// ignore_for_file: use_build_context_synchronously, no_logic_in_create_state, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sa3/controller_database.dart';
import 'package:sa3/model_user.dart';
import 'package:sa3/view_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  final String email;

  const ConfiguracoesPage({super.key, required this.email});

  @override
  _ConfiguracoesPageState createState() =>
      _ConfiguracoesPageState(email: email);
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late SharedPreferences _prefs;
  bool _darkMode = false;
  final String email;
  String _idioma = 'pt-br';
  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _senhaController;

  _ConfiguracoesPageState({required this.email});

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _nomeController = TextEditingController();
    _emailController = TextEditingController();
    _senhaController = TextEditingController();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = _prefs.getBool('${email}darkMode') ?? false;
      _idioma = _prefs.getString('${email}SelIdioma') ?? 'pt-br';
    });

    // Carregar informações do usuário e definir nos campos de texto
    final user = await BancoDadosCrud().getUser(email, '');
    if (user != null) {
      _nomeController.text = user.nome;
      _emailController.text = user.email;
      // Não recomendado exibir a senha atual
      // _senhaController.text = user.senha;
    }
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

    await _prefs.setString('${email}SelIdioma', _idioma);
  }

  Future<void> _fazerLogoff() async {
    await AuthController.fazerLogoff();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<void> _atualizarInformacoesUsuario() async {
    final novoNome = _nomeController.text.trim();
    final novoEmail = _emailController.text.trim();
    final novaSenha = _senhaController.text.trim();

    // Lógica para atualizar as informações do usuário no banco de dados
    try {
      final user = await BancoDadosCrud().getUser(email, '');
      if (user != null) {
        // Criar uma instância temporária de User com as novas informações
        final novoUser = User(nome: novoNome, email: novoEmail, senha: novaSenha);
        // Copiar o ID do usuário existente para o novo usuário
        novoUser.setId(user.id);
        // Atualizar o usuário existente com as novas informações
        await BancoDadosCrud().update(novoUser);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Informações do usuário atualizadas com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro: Usuário não encontrado')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao atualizar as informações do usuário')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
          bottom: TabBar(
            tabs: [
              Tab(
                  text: _idioma == 'pt-br'
                      ? 'Sistema'
                      : _idioma == 'en-us'
                          ? 'System'
                          : _idioma == 'es-ar'
                              ? 'Sistema'
                              : ''),
              Tab(
                  text: _idioma == 'pt-br'
                      ? 'Usuário'
                      : _idioma == 'en-us'
                          ? 'User'
                          : _idioma == 'es-ar'
                              ? 'Usuario'
                              : ''),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Aba de configurações do sistema
            Center(
              child: Column(
                children: [
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
            // Aba de configurações do usuário
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _idioma == 'pt-br'
                          ? 'Editar Informações do Usuário'
                          : _idioma == 'en-us'
                              ? 'Edit User Information'
                              : _idioma == 'es-ar'
                                  ? 'Editar Información de Usuario'
                                  : '',
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        labelText: _idioma == 'pt-br'
                            ? 'Nome'
                            : _idioma == 'en-us'
                                ? 'Name'
                                : _idioma == 'es-ar'
                                    ? 'Nombre'
                                    : '',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: _idioma == 'pt-br'
                            ? 'Email'
                            : _idioma == 'en-us'
                                ? 'Email'
                                : _idioma == 'es-ar'
                                    ? 'Correo Electrónico'
                                    : '',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _senhaController,
                      decoration: InputDecoration(
                        labelText: _idioma == 'pt-br'
                            ? 'Senha'
                            : _idioma == 'en-us'
                                ? 'Password'
                                : _idioma == 'es-ar'
                                    ? 'Contraseña'
                                    : '',
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _atualizarInformacoesUsuario,
                      child: Text(
                        _idioma == 'pt-br'
                            ? 'Salvar Alterações'
                            : _idioma == 'en-us'
                                ? 'Save Changes'
                                : _idioma == 'es-ar'
                                    ? 'Guardar Cambios'
                                    : '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
