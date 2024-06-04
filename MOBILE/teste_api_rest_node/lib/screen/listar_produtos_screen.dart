import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:teste_api_rest_node/controller/produtos_controller.dart';

class ListarProdutosScreen extends StatefulWidget {
  const ListarProdutosScreen({super.key});

  @override
  State<ListarProdutosScreen> createState() => _ListarProdutosScreenState();
}

class _ListarProdutosScreenState extends State<ListarProdutosScreen> {
  final ProdutosController _controller = ProdutosController();

  Future<void> _getProdutos() async {
    try {
      await _controller.getProdutos();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produto'),
      ),
      body: FutureBuilder(
        future: _getProdutos(),
        builder: (context, snapshot) {
          if (_controller.listProdutos.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _controller.listProdutos.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(_controller.listProdutos[index].nome),
                    subtitle: Text(_controller.listProdutos[index].codigo),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await _controller
                            .deleteProduto(_controller.listProdutos[index].id);
                        setState(() {
                          _controller.getProdutos();
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
