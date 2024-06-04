import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_api_rest_node/controller/produtos_controller.dart';
import 'package:teste_api_rest_node/model/produtos_model.dart';

class CadastrarProdutoScreen extends StatefulWidget {
  const CadastrarProdutoScreen({super.key});

  @override
  State<CadastrarProdutoScreen> createState() => _CadastrarProdutoScreenState();
}

class _CadastrarProdutoScreenState extends State<CadastrarProdutoScreen> {
  final ProdutosController _controller = ProdutosController();
  final TextEditingController _nomeText = TextEditingController();
  final TextEditingController _precoText = TextEditingController();
  final TextEditingController _codigoText = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.getProdutos();
  }

  Future<void> postProduto() async {
    Produto produto = Produto(
        id: (_controller.listProdutos.length + 1).toString(),
        nome: _nomeText.text,
        codigo: _codigoText.text,
        preco: double.parse(_precoText.text));
    try {
      await _controller.postProduto(produto);
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
        title: const Text('Cadastro de Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeText,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _codigoText,
              decoration: InputDecoration(
                labelText: 'Código',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _precoText,
              decoration: InputDecoration(
                labelText: 'Preço',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _cadastrar(),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

  _cadastrar() {
    return () {
      postProduto();
      _nomeText.clear();
      _codigoText.clear();
      _precoText.clear();
      _controller.getProdutos();
    };
  }
}
