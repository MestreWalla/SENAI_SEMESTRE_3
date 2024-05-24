import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:projeto_api_geo/Model/city_model.dart';
import 'package:sqflite/sqflite.dart';

class CityDbService {
  static const String dbName = 'cities.db'; // Nome do banco de dados
  static const String tableName = 'cities'; // Nome da tabela
  static const String
      createContactsTableScript = // Script SQL para criar a tabela
      "CREATE TABLE IF NOT EXISTS $tableName ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "cityname TEXT, "
      "favoritecities BOOLEAN default false)";

  // Método para obter o banco de dados
  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) {
        return db.execute(createContactsTableScript);
      },
      version: 1,
    );
  }

  Future<List<City>> getAllCities() async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(
      maps.length,
      (i) {
        return City.fromMap(maps[i]);
      },
    );
  }

  Future<int> insertCity(City city) async {
    try {
      Database db = await _getDatabase();
      if (kDebugMode) {
        print("banco");
      }
      return await db.insert(tableName, city.toMap());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 0;
    }
  }

  // Update
  Future<void> updateCity(City city) async {
    try {
      Database db = await _getDatabase();
      print("banco");
      db.update(tableName, city.toMap(), 
        where: "cityname =?", 
        whereArgs: [city.cityName]
        );
    } catch (e) {
      print(e);
    }
  }
}
