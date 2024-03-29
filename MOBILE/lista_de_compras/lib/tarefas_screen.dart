// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lista_de_compras/tarefas_controller.dart';

class TarefasScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 188, 228, 245),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 130, 156),
        title: Row(
          children: [
            Icon(
              Icons.clear_all,
              size: 25,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            SizedBox(width: 8),
            Text(
              'Lista de Compras',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Adicionar Função
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                labelText: 'Novo item',
                suffixIcon: IconButton(
                  onPressed: () {
                    _adicionarTarefa(context);
                  },
                  icon: Icon(Icons.add),
                ),
              ),
              onSubmitted: (_) {
                _adicionarTarefa(context);
              },
            ),
          ),
          Expanded(
            child: Consumer<TarefasController>(
              builder: (context, model, child) {
                return ListView.builder(
                  itemCount: model.tarefas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(model.tarefas[index].descricao),
                      trailing: Checkbox(
                        value: model.tarefas[index].concluida,
                        onChanged: (value) {
                          model.marcarComoConcluida(index);
                        },
                      ),
                      onLongPress: () {
                          model.excluirTarefa(context, index);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 63, 130, 156),
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Provider.of<TarefasController>(context, listen: false)
                    .limparLista(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 229, 91, 91),
                onPrimary: Colors.white,
                shape: BeveledRectangleBorder(),
              ),
              icon: Icon(Icons.clear),
              label: Text('Excluir tudo'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Provider.of<TarefasController>(context, listen: false)
                    .limparTarefasMarcadas(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 185, 193, 62),
                onPrimary: const Color.fromARGB(255, 0, 0, 0),
                shape: BeveledRectangleBorder(),
              ),
              icon: Icon(Icons.clear),
              label: Text('Excluir conluidos'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Provider.of<TarefasController>(context, listen: false)
                    .ordenarTarefasPorNome();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                shape: BeveledRectangleBorder(),
              ),
              icon: Icon(Icons.sort_by_alpha),
              label: Text('Ordenar'),
            ),
          ],
        ),
      ),
    );
  }

  void _adicionarTarefa(BuildContext context) {
    Provider.of<TarefasController>(context, listen: false)
        .adicionarTarefa(_controller.text);
    _controller.clear();
    _focusNode.requestFocus(); // Retorna o foco para o campo de texto
  }
}
