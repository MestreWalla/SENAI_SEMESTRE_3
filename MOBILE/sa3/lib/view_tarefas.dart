// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sa3/controller_database.dart';
import 'package:sa3/controller_tarefas.dart';
import 'package:sa3/model_tarefas.dart';

class TarefasView extends StatefulWidget {
  final String email;
  final String senha;

  const TarefasView({Key? key, required this.email, required this.senha})
      : super(key: key);

  @override
  _TarefasViewState createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  final TarefaController _controller = TarefaController();
  TextEditingController _tituloController = TextEditingController();
  int? userId;

  @override
  void initState() {
    super.initState();
    _buscarUserId(); // Chame _buscarUserId no initState
  }

  Future<void> _buscarUserId() async {
    try {
      print('Iniciando busca do ID do usuário...');
      final userIdObject =await BancoDadosCrud().getUser(widget.email, widget.senha);
      print('Resultado da consulta ao banco de dados: $userIdObject');
      if (userIdObject != null) {
        print('Usuário encontrado no banco de dados.');
        final id = userIdObject.id;
        if (id != null) {
          setState(() {
            userId = int.parse(id.toString());
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuário autenticado com sucesso.'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          print('ID do usuário inválido: $id');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro ao autenticar o usuário. Tente novamente mais tarde.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        print('Usuário não encontrado no banco de dados.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não encontrado. Verifique suas credenciais.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (ex) {
      print('Erro ao buscar ID do usuário: $ex');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao buscar ID do usuário. Por favor, tente novamente mais tarde.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Construindo TarefasView...');
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

  Future<List<Tarefa>> getTarefasNaoConcluidas() async {
    try {
      print('Obtendo tarefas não concluídas...');
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

  Future<List<Tarefa>> getTarefasConcluidas() async {
    try {
      print('Obtendo tarefas concluídas...');
      final List<Tarefa> tarefas = await _controller.getTarefasConcluidas();
      return tarefas;
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      throw Exception("Erro ao obter as tarefas concluídas do banco de dados");
    }
  }

  Widget _buildTarefasNaoConcluidas() {
    print('Construindo lista de tarefas não concluídas...');
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
    print('Construindo lista de tarefas concluídas...');
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
    print('Mostrando diálogo para adicionar tarefa...');
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
                if (titulo.isNotEmpty && userId != null) {
                  // Verifique se userId não é nulo
                  final novaTarefa = Tarefa(
                    titulo: titulo,
                    concluida: false,
                    usuarioId: userId!, // Use userId
                  );
                  await _controller.adicionarTarefa(novaTarefa, userId!);
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
