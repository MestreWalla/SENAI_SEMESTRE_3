import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto_json/Controller/carros_controller.dart';
import 'package:projeto_json/Model/carros_model.dart';

class CarrosListarScreen extends StatefulWidget {
  const CarrosListarScreen({Key? key});

  @override
  State<CarrosListarScreen> createState() => _CarrosListarScreenState();
}

class _CarrosListarScreenState extends State<CarrosListarScreen> {
  CarrosController controller = CarrosController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Carros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder(
          future: controller.loadCarrosFromFile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar os carros: ${snapshot.error}'),
              );
            } else {
              return ListView.builder(
                itemCount: controller.carroList.length,
                itemBuilder: (context, index) {
                  final carro = controller.carroList[index];
                  return ListTile(
                    leading: Image.file(File(carro.foto)),
                    title: Text(carro.modelo),
                    subtitle: Text(carro.marca),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _editarCarro(context, carro);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _confirmarExclusao(context, carro);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  void _editarCarro(BuildContext context, Carro carro) {
    showDialog(
      context: context,
      builder: (context) {
        String novoModelo = carro.modelo;
        String novaMarca = carro.marca;
        return AlertDialog(
          title: const Text('Editar Carro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Novo Modelo'),
                onChanged: (value) {
                  novoModelo = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Nova Marca'),
                onChanged: (value) {
                  novaMarca = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  carro.modelo = novoModelo;
                  carro.marca = novaMarca;
                });
                // Aqui você pode chamar a função para salvar as alterações
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _confirmarExclusao(BuildContext context, Carro carro) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: const Text('Deseja realmente excluir este carro?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _excluirCarro(context, carro);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _excluirCarro(BuildContext context, Carro carro) {
    setState(() {
      // Aqui você pode chamar a função para excluir o carro da lista
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Carro ${carro.modelo} excluído com sucesso!'),
      ),
    );
  }
}
