// ignore_for_file: library_private_types_in_public_api

import 'package:exemplo_json/Controller/produtos_controller.dart';
import 'package:exemplo_json/Model/produtos_model.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final ProdutoController _produtoController = ProdutoController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _produtoController.loadProdutos();
  }


  void _adicionarProduto() {
    final nome = _nomeController.text;
    final preco = double.tryParse(_precoController.text) ?? 0.0;
    final categoria = _categoriaController.text;
    if (nome.isNotEmpty && preco > 0 && categoria.isNotEmpty) {
      setState(() {
        _produtoController.adicionarProduto(Produto(nome: nome, preco: preco, categoria: categoria));
        _produtoController.saveProdutos();
      });
      _nomeController.clear();
      _precoController.clear();
      _categoriaController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produtos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do produto'),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _precoController,
              decoration: const InputDecoration(labelText: 'Preço'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _categoriaController,
              decoration: const InputDecoration(labelText: 'Categoria'),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: _adicionarProduto,
              child: const Text('Adicionar Produto'),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Lista de Produtos:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _produtoController.produtos.length,
                itemBuilder: (context, index) {
                  final produto = _produtoController.produtos[index];
                  return ListTile(
                    title: Text(produto.nome),
                    subtitle: Text('Preço: ${produto.preco.toStringAsFixed(2)} - Categoria: ${produto.categoria}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
