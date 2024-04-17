// arquivo view_tarefas.dart
import 'package:flutter/material.dart';
import 'controller_tarefas.dart';
import 'model_tarefas.dart';

class TarefasView extends StatefulWidget {
  const TarefasView({Key? key}) : super(key: key);

  @override
  _TarefasViewState createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  final TarefaController _controller = TarefaController();
  TextEditingController _tituloController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
      ),
      body: FutureBuilder<List<Tarefa>>(
        future: _controller.getTarefas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar tarefas'));
          } else {
            List<Tarefa> tarefas = snapshot.data!;
            return ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = tarefas[index];
                return ListTile(
                  title: Text(tarefa.titulo),
                  leading: Checkbox(
                    value: tarefa.concluida,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarDialogAdicionarTarefa(context);
        },
        child: const Icon(Icons.add),
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
                  final novaTarefa =
                      Tarefa(titulo: titulo, concluida: false);
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
