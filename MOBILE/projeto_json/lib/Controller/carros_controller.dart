import 'dart:io';

class CarrosController {
  final List<Carro> _carros = [];

  List<Carro> getCarros() {
    return _carros;
  }

  Future<void> cadastrarCarro(
    String nome,
    String placa,
    String modelo,
    String marca,
    int ano,
    String cor,
    String descricao,
    double valor,
    File imagem,
  ) async {
    final carro = Carro(
      nome: nome,
      placa: placa,
      modelo: modelo,
      marca: marca,
      ano: ano,
      cor: cor,
      descricao: descricao,
      valor: valor,
      imagem: imagem,
    );
    _carros.add(carro);
  }
}

class Carro {
  final String nome;
  final String placa;
  final String modelo;
  final String marca;
  final int ano;
  final String cor;
  final String descricao;
  final double valor;
  final File imagem;

  Carro({
    required this.nome,
    required this.placa,
    required this.modelo,
    required this.marca,
    required this.ano,
    required this.cor,
    required this.descricao,
    required this.valor,
    required this.imagem,
  });
}