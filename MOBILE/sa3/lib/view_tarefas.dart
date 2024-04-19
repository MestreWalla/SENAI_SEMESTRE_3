// arquivo view_tarefas.dart
// ignore_for_file: use_build_context_synchronously, prefer_final_fields, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'controller_tarefas.dart';
import 'model_tarefas.dart';
import 'package:flutter/foundation.dart';

class TarefasView extends StatefulWidget {
  const TarefasView({super.key});

  @override
  _TarefasViewState createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  final TarefaController _controller = TarefaController();
  TextEditingController _tituloController = TextEditingController();

  Future<List<Tarefa>> getTarefasConcluidas() async {
    try {
      final List<Tarefa> tarefas = await _controller.getTarefasConcluidas();
      return tarefas;
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      throw Exception("Erro ao obter as tarefas concluídas do banco de dados");
    }
  }

  Future<List<Tarefa>> getTarefasNaoConcluidas() async {
    try {
      final List<Tarefa> tarefas = await _controller.getTarefasNaoConcluidas();
      return tarefas;
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      throw Exception(
          "Erro ao obter as tarefas não concluídas do banco de dados");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
      ),
      body: Column(
        children: [
          _buildTarefasNaoConcluidas(),
          _buildTarefasConcluidas(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarDialogAdicionarTarefa(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTarefasNaoConcluidas() {
    return Expanded(
      child: SingleChildScrollView(
        child: FutureBuilder<List<Tarefa>>(
          future: getTarefasNaoConcluidas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text('Erro ao carregar tarefas não concluídas'));
            } else {
              List<Tarefa> tarefasNaoConcluidas = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tarefasNaoConcluidas.length,
                itemBuilder: (context, index) {
                  final tarefa = tarefasNaoConcluidas[index];
                  return ListTile(
                    title: Text(tarefa.titulo),
                    leading: Checkbox(
                      value: false,
                      onChanged: (value) {
                        setState(() {
                          if (value != null && value) {
                            _controller.marcarComoConcluida(tarefa.id);
                          } else {
                            _controller.desmarcarComoConcluida(tarefa.id);
                          }
                        });
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _controller.removerTarefa(tarefa.id);
                        });
                      },
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

  Widget _buildTarefasConcluidas() {
    return Expanded(
      child: SingleChildScrollView(
        child: FutureBuilder<List<Tarefa>>(
          future: getTarefasConcluidas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text('Erro ao carregar tarefas concluídas'));
            } else {
              List<Tarefa> tarefasConcluidas = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tarefasConcluidas.length,
                itemBuilder: (context, index) {
                  final tarefa = tarefasConcluidas[index];
                  return ListTile(
                    title: Text(tarefa.titulo),
                    leading: Checkbox(
                      value: true,
                      onChanged: (value) {
                        setState(() {
                          _controller.desmarcarComoConcluida(
                              tarefa.id); // Desmarca a tarefa como concluída
                        });
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _controller.removerTarefa(tarefa.id);
                        });
                      },
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

  void _mostrarDialogAdicionarTarefa(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Tarefa'),
          content: TextField(
            controller: _tituloController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final titulo = _tituloController.text;
                if (titulo.isNotEmpty) {
                  final novaTarefa = Tarefa(titulo: titulo, concluida: false);
                  await _controller.adicionarTarefa(novaTarefa);
                  _tituloController.clear();
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tarefa adicionada com sucesso!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  setState(() {});
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
