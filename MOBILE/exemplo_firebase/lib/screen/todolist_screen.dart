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

  Future<void> _getList() async {
    try {
      await _controller.fetchList(widget.user.uid);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Todo List Firebase'), actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                //chamar o logout
                await _service.logoutUsuario();
                Navigator.pushReplacementNamed(context, '/home');
              })
        ]),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: _getList(),
                      builder: (context, snapshot) {
                        if (_controller.list.isNotEmpty) {
                          return ListView.builder(
                            itemCount: _controller.list.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_controller.list[index].titulo),
                                // subtitle: Text(_controller.list[index].description),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await _controller
                                        .delete(_controller.list[index].id);
                                    _getList();
                                    setState(() {});
                                  },
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {

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
                        onPressed: () {
                          Navigator.of(context).pop();
                          Todolist add = Todolist(
                              id: "",
                              titulo: _tituloController.text,
                              userId: widget.user.uid,
                              timestamp: DateTime.now());
                          _controller.add(add);
                          _getList();
                          setState(() {});
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                        child: const Text("Salvar"),
                      ),
                    ]);
              });
        }));
  }
}
