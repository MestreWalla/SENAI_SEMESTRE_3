import 'dart:convert';

import 'package:teste_api_rest_node/model/produtos_model.dart';
import 'package:http/http.dart' as http;

class ProdutosController {
  List<Produto> _listProdutos = [];
  List<Produto> get listProdutos => _listProdutos;
  final _url = 'http://10.109.204.26:3000/produtos';
  //getProdutofromJson
  Future<List<Produto>> getProdutos() async {
    final response =
        await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      List<dynamic> result = json.decode(response.body);
      _listProdutos = result.map((e) => Produto.fromJson(e)).toList();
      return _listProdutos;
    } else {
      throw Exception('Não foi possível conectar com o servidor');
    }
  }

  //postProdutoToJson
  Future<String> postProduto(Produto produto) async {
    final response = await http.post(
        Uri.parse(_url),
        body: json.encode(produto.toJson()),
        headers: {'Content-Type': 'application/json'}
        );
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Não foi possível enviar ao servidor');
    }
  }

    Future<void> deleteProduto(String id) async {
    try {
      final response = await http.delete(Uri.parse('$_url/$id'));
      if (response.statusCode == 200) {
        _listProdutos.removeWhere((produto) => produto.id == id);
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

}
