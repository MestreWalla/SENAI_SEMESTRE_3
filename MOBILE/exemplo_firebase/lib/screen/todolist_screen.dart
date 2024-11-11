import 'package:exemplo_firebase/controller/todolist_controller.dart';
import 'package:exemplo_firebase/models/todolist.dart';
import 'package:exemplo_firebase/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TodolistScreen extends StatefulWidget {
  final User user;
  const TodolistScreen({super.key, required this.user});

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  final AuthService _service = AuthService();
  final TodolistController _controller = TodolistController();
  final _tituloController = TextEditingController();

  // Variável para controlar o carregamento da lista
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getList(); // Carrega a lista ao iniciar a tela
  }

  Future<void> _getList() async {
    try {
      await _controller.fetchList(widget.user.uid);
      setState(() {
        _isLoading = false; // Carregamento concluído
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List Firebase'), actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await _service.logoutUsuario();
            Navigator.pushReplacementNamed(context, '/home');
          },
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Expanded(
                      child: _controller.list.isNotEmpty
                          ? ListView.builder(
                              itemCount: _controller.list.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(_controller.list[index].titulo),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      await _controller.delete(
                                          _controller.list[index].id);
                                      _getList(); // Atualiza a lista após deletar
                                    },
                                  ),
                                );
                              },
                            )
                          : const Text('Nenhuma tarefa adicionada'),
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Nova Tarefa"),
                  content: TextFormField(
                    controller: _tituloController,
                    decoration:
                        const InputDecoration(hintText: "Digite a tarefa"),
                  ),
                  actions: [
                    TextButton(
                      child: const Text("Cancelar"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        Todolist add = Todolist(
                          id: "",
                          titulo: _tituloController.text,
                          userId: widget.user.uid,
                          timestamp: DateTime.now(),
                        );
                        await _controller.add(add);
                        _tituloController.clear(); // Limpa o campo após salvar
                        _getList(); // Atualiza a lista após adicionar
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                      child: const Text("Salvar"),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
