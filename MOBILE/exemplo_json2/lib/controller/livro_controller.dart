import 'dart:convert';

import 'package:exemplo_json2/model/livro_model.dart';
import 'package:flutter/services.dart';

class LivroController {
  List<Livro> livros = [];

  Future<List<Livro>> loadLivros() async {
    final data = await rootBundle.loadString("assets/livros.json");
    final listLivros = json.decode(data).toString() as List<dynamic>;
    livros.clear();
    livros.addAll(listLivros.map((e) => Livro.fromJson(e)));
    return Future.delayed(const Duration(seconds: 2), () {
      return livros;
    });
  }
}
