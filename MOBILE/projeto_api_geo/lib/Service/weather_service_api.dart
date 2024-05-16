import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  // Atributos
  final String apiKey = 'b9ebe666087f299f5e2aad3a03d093b6';
  final String url = 'https://api.openweathermap.org/data/2.5';
  
  //constructores
  
  // Método para obter o clima por cidade
  Future<Map<String, dynamic>> getWeather(String city) async {
    final uri = Uri.parse('$url/weather?q=$city&appid=$apiKey');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Método para obter o clima por localização (latitude e longitude)
  Future<Map<String, dynamic>> getWeatherByLocation(double lat, double lon) async {
    final uri = Uri.parse('$url/weather?lat=$lat&lon=$lon&appid=$apiKey');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather by gps data');
    }
  }
}
