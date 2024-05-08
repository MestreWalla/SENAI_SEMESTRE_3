import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_json/Controller/carros_controller.dart';
import 'package:projeto_json/Model/carros_model.dart';

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
  void initState() {
    super.initState();
    _controller.loadCarrosFromFile();
  }

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

  Carro criarObjeto() {
    return Carro(
      nome: _nomeController.text,
      placa: _placaController.text,
      modelo: _modeloController.text,
      marca: _marcaController.text,
      ano: int.parse(_anoController.text),
      cor: _corController.text,
      descricao: _descricaoController.text,
      valor: double.parse(_valorController.text),
      foto: _imagemSelecionada!.path,
    );
  }

  final CarrosController _controller = CarrosController();

  void _limparValores() {
    _nomeController.clear();
    _placaController.clear();
    _modeloController.clear();
    _marcaController.clear();
    _anoController.clear();
    _corController.clear();
    _descricaoController.clear();
    _valorController.clear();
    _imagemSelecionada = null;
    _formKey.currentState!.reset();
  }

  void _apagarCampos() {
    _nomeController.clear();
    _placaController.clear();
    _modeloController.clear();
    _marcaController.clear();
    _anoController.clear();
    _corController.clear();
    _descricaoController.clear();
    _valorController.clear();
    _imagemSelecionada = null;
    _formKey.currentState!.reset();
  }

  void _cadastrarCarro() {
    if (_controller.placaExiste(_placaController.text)) {
      // Se a placa já existe, exiba uma mensagem ou realize a ação apropriada
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Placa já cadastrada!"),
        ),
      );
      return; // Sai do método sem adicionar o carro
    }

    // Se a placa não existe, continue com o cadastro do carro
    _controller.addCarro(criarObjeto());
    _controller.saveCarrosToFile();
    _limparValores();
    _apagarCampos();

    // Snackbar informando que o carro foi cadastrado com sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Carro cadastrado com sucesso!"),
      ),
    );
  }
}
