// ignore_for_file: prefer_final_fields, non_constant_identifier_names

import 'package:app_carros/model.dart';

class CarroController {
  //Atributo
  List<Carro> _CarrosLista = [
    Carro ("Fiat Uno", 1992, "lib/img/uno.webp"),
    Carro ("Classic", 2012, "lib/img/classic.jpg"),
    Carro ("Gol", 2001, "lib/img/gol.webp"),
    Carro("HB20", 2015, "lib/img/hb20.jpg"),
  ];

  //Métodos
  List<Carro> get listarCarros => _CarrosLista;

  void adicionarCarro(String modelo, int ano, String imagemUrl) {
    Carro carro = Carro(modelo, ano, imagemUrl);
    _CarrosLista.add(carro);
  }

  void excluirCarro(int index) {}

  void detalharCarro(int index) {}

  void addCarros() {}
}
