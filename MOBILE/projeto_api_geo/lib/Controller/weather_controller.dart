import 'package:flutter/foundation.dart';
import 'package:projeto_api_geo/Model/weather_model.dart';
import 'package:projeto_api_geo/Service/weather_service_api.dart';

class WeatherController {
  //atributos
  final WeatherService _service = WeatherService();
  final List<Weather> _weatherList = [];

  //get
  List<Weather> get weatherList => _weatherList;

  //metodos
  Future<void> getWeather(String city) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeather(city));
      weatherList.add(weather);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  //metodo para buscar por longitude e latitude
  Future<void> getWeatherByLocation(double longitude, double latitude) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeatherByLocation(longitude, latitude));
      weatherList.add(weather);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
