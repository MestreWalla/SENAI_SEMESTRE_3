import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarroCadastroScreen extends StatefulWidget {
  const CarroCadastroScreen({super.key});

  @override
  State<CarroCadastroScreen> createState() => _CarroCadastroScreenState();
}

class _CarroCadastroScreenState extends State<CarroCadastroScreen> {
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _corController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  File? _imagemSelecionada;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Carro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Nome do Carro"),
                      controller: _nomeController,
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
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Modelo do Carro"),
                    controller: _modeloController,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Insira o modelo do carro";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Marca do Carro"),
                    controller: _marcaController,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Insira a marca do carro";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Ano do Carro"),
                    controller: _anoController,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Insira o ano do carro";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "cor do Carro"),
                    controller: _corController,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Insira a cor do carro";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Descriçao do Carro"),
                    controller: _descricaoController,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Insira a descrição do carro";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Valor do Carro"),
                    controller: _valorController,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Insira o valor do carro";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _imagemSelecionada != null
                      ? Image.file(
                          _imagemSelecionada!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox.shrink(),
                  ElevatedButton(
                    onPressed: _tirarFoto,
                    child: const Text('Tirar Foto'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _cadastrarCarro();
                        }
                      },
                      child: const Text("cadastrar"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _tirarFoto() async {
    // ImagePicker - importar com comando: flutter pub add image_picker
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
      });
    }
  }

  void _cadastrarCarro() {}
}
