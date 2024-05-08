import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../Model/carros_model.dart';

class CarrosController {
  List<Carro> _carroList = [];

  List<Carro> get carroList {
    return _carroList;
  }

  void addCarro(Carro carro) {
    _carroList.add(carro);
    saveCarrosToFile();
  }

  void deleteCarro(Carro carro) {
    _carroList.removeAt(0);
    saveCarrosToFile();
  }

  void editCarro(Carro carro) {
    // Encontre o índice do carro na lista
    final index =
        _carroList.indexWhere((element) => element.placa == carro.placa);
    if (index == -1) return;
    _carroList[index] = carro;
    saveCarrosToFile();
  }

  //Salva para o Json
  Future<void> saveCarrosToFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    final file = File('$path/carros.json');
    final jsonList = _carroList.map((carro) => carro.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  //Buscar do Json
  Future<void> loadCarrosFromFile() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String path = appDocDir.path;
      final file = File('$path/carros.json');
      final jsonList = jsonDecode(await file.readAsString());
      _carroList = jsonList.map<Carro>((json) => Carro.fromJson(json)).toList();
    } catch (e) {
      _carroList = [];
    }
  }

  bool placaExiste(String placa) {
    for (var carro in carroList) {
      if (carro.placa == placa) {
        return true; // Placa já existe na lista
      }
    }
    return false; // Placa não encontrada na lista
  }
}
