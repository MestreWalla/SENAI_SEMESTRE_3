import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:projeto_json/Model/produtos_model.dart';

/// Esta classe é responsável por gerenciar os produtos e salvá-los em um arquivo JSON.
class ProdutoController {
  /// Uma lista para armazenar os produtos.
  List<Produto> _produtos = [];

  /// Getter para acessar a lista de produtos.
  List<Produto> get produtos => _produtos;

  /// Este método seta a lista de produtos.
  void setProdutos(List<Produto> produtos) {
    _produtos = produtos;
  }

  /// Este método salva os produtos em um arquivo JSON chamado 'produtos.json'.
  /// Ele primeiro converte cada produto em um objeto JSON usando o método 'toJson',
  /// depois ele escreve a lista de objetos JSON no arquivo.
  Future<void> salvarJson() async {
    final file = File('produtos.json');
    final jsonList = _produtos.map((produto) => produto.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }

  /// Este método carrega os produtos do arquivo JSON chamado 'produtos.json'.
  /// Ele primeiro converte cada produto em um objeto JSON usando o método 'fromJson'.
  /// depois ele adiciona o objeto JSON na lista de objetos JSON.
  Future<List<Produto>> carregarJson() async {
    try {
      final file = File('produtos.json');
      final jsonList = json.decode(await file.readAsString());
      _produtos.addAll(jsonList.map((produto) => Produto.fromJson(produto)));
    } catch (e) {
      // Caso o arquivo nao exista ou ocorra um erro na leitura, não faça nada
      _produtos = [];
      if (kDebugMode) {
        print("O arquivo Produto nao existe ou não pode ser lido - Error: $e");
      }
    }
    return _produtos;
  }
}
