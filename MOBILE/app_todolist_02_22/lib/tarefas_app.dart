import 'package:app_todolist_02_22/tarefas_controller.dart';
import 'package:app_todolist_02_22/tarefas_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarefasApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      // Definindo a tela Inicial como a Tarefa
      home: ChangeNotifierProvider
        (create: (context) => TarefasController(),
        child: TarefasScreen(),
      ),
    );
  }
}