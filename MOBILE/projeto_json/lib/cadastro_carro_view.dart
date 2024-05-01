import 'package:flutter/material.dart';

class CarroCadastroScreen extends StatefulWidget {
  const CarroCadastroScreen({super.key});

  @override
  State<CarroCadastroScreen> createState() => _CarroCadastroScreenState();
}

class _CarroCadastroScreenState extends State<CarroCadastroScreen> {
  final TextEditingController _placaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Carro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Nome do Carro"),
                    controller: _placaController,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Insira o nome do carro";
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Placa do Carro"),
                    controller: _placaController,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Insira a placa do carro";
                      } else {
                        return null;
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
