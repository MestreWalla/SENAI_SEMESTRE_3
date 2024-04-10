//arquivo view_cadastro.dart
import 'package:flutter/material.dart';
import 'package:sa2/controller_cadastro.dart';
import 'package:sa2/model_usuario.dart';

class CadastroPage extends StatefulWidget {
  final ValueNotifier<bool> temaEscuroNotifier; // Adicione este parâmetro
  CadastroPage({Key? key, required this.temaEscuroNotifier})
      : super(key: key); // Adicione este construtor

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final CadastroController controller = CadastroController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: enderecoController,
              decoration: const InputDecoration(
                labelText: 'Endereço',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                CadastroController().cadastrar(
                  UsuarioModel(
                    id: 0, // Você pode definir como quiser, dependendo da lógica do seu banco de dados
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    endereco: enderecoController.text,
                    senha: passwordController.text,
                  ),
                );
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
