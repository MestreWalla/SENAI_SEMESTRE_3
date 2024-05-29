import 'package:projeto_api_geo/Model/city_model.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';

class CityDbController {
  // Atributo
  List<City> _cities = [];
  final CityDbService _dbService = CityDbService();
  // Get
  List<City> cities() => _cities;
  // Metodos
  Future<List<City>> listCities() async {
    List<Map<String, dynamic>> maps = await _dbService.getAllCities();
    _cities = maps.map<City>((e) => City.fromMap(e)).toList();
    return _cities;
  }
  // Add cities
  Future<void> addCity(City city) async {
    _dbService.insertCity(city);
  }
}
