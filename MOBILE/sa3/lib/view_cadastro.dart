// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, use_key_in_widget_constructors
// Arquivo view_cadastro
import 'package:flutter/material.dart';
import 'package:sa3/controller_database.dart';
import 'package:sa3/model_user.dart';

class CadastroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voltar'),
      ),
      body: Center(
        child: CadastroForm(),
      ),
    );
  }
}

class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void cadastrarUsuario() async {
  if (_formKey.currentState!.validate()) {
    String name = _nomeController.text;
    String email = _emailController.text;
    String password = _senhaController.text;

    print('Dados do formulário:');
    print('Nome: $name');
    print('Email: $email');
    print('Senha: $password');

    User user = User(nome: name, email: email, senha: password);

    BancoDadosCrud bancoDados = BancoDadosCrud();
    try {
      // Verifica se o usuário já existe no banco de dados antes de cadastrar
      if (await bancoDados.existsUser(email, password)) {
        print('Usuário já cadastrado.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário já cadastrado')),
        );
      } else {
        // Se o usuário não existir, realiza o cadastro
        print('Usuário não cadastrado. Realizando cadastro...');
        await bancoDados.create(user);
        print('Usuário cadastrado com sucesso!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print('Erro ao cadastrar usuário: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar usuário: $e')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Cadastro',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira seu nome';
                }
                if (!RegExp(r'^[a-zA-ZÀ-ú-\s]+$').hasMatch(value!)) {
                  return 'Nome inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira seu e-mail';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value!)) {
                  return 'E-mail inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira sua senha';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: cadastrarUsuario,
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
