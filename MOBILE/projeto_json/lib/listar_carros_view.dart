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
  Map<int, bool> isExpandedMap = {};

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
                  final isExpanded = isExpandedMap[index] ?? false;
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          setState(() {
                            isExpandedMap[index] = !isExpanded;
                          });
                        },
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
                      ),
                      if (isExpanded) ...[
                        Text('Nome: ${carro.nome}'),
                        Text('Cor: ${carro.cor}'),
                        Text('Ano: ${carro.ano}'),
                        Text('Valor: ${carro.valor}'),
                        Text('Placa: ${carro.placa}'),
                        Text('Descricao: ${carro.descricao}'),
                      ],
                      const Divider(),
                    ],
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
        String novoNome = carro.nome;
        String novaPlaca = carro.placa;
        String novaCor = carro.cor;
        double novoValor = carro.valor;
        String novoDescricao = carro.descricao;
        int novoAno = carro.ano;

        return AlertDialog(
          title: const Text('Editar Carro'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Novo Modelo'),
                  controller: TextEditingController(text: novoModelo),
                  onChanged: (value) {
                    novoModelo = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Nova Marca'),
                  controller: TextEditingController(text: novaMarca),
                  onChanged: (value) {
                    novaMarca = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Novo Nome'),
                  controller: TextEditingController(text: novoNome),
                  onChanged: (value) {
                    novoNome = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Nova Placa'),
                  controller: TextEditingController(text: novaPlaca),
                  onChanged: (value) {
                    novaPlaca = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Nova Cor'),
                  controller: TextEditingController(text: novaCor),
                  onChanged: (value) {
                    novaCor = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Novo Valor'),
                  controller: TextEditingController(text: novoValor.toString()),
                  onChanged: (value) {
                    novoValor = double.tryParse(value) ?? 0.0;
                  },
                ),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Nova Descrição'),
                  controller: TextEditingController(text: novoDescricao),
                  onChanged: (value) {
                    novoDescricao = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Novo Ano'),
                  controller: TextEditingController(text: novoAno.toString()),
                  onChanged: (value) {
                    novoAno = int.tryParse(value) ?? 0;
                  },
                ),
              ],
            ),
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
                  carro.nome = novoNome;
                  carro.placa = novaPlaca;
                  carro.cor = novaCor;
                  carro.valor = novoValor;
                  carro.descricao = novoDescricao;
                  carro.ano = novoAno;
                });
                controller.editCarro(carro);
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
      controller.deleteCarro(carro);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Carro ${carro.modelo} excluído com sucesso!'),
      ),
    );
  }
}
