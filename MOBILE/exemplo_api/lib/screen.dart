// ignore_for_file: unused_field

import 'package:exemplo_api/sevice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // Instância do serviço WeatherService para obter os dados de previsão do tempo.
  final WeatherService _weatherService = WeatherService(
    apiKey:
        '681126f28e7d6fa3a7cfe0da0671e599', // Chave de API para acesso à API de previsão do tempo.
    baseUrl:
        'https://api.openweathermap.org/data/2.5', // URL base da API de previsão do tempo.
  );

  // Mapa que armazenará os dados de previsão do tempo.
  late Map<String, dynamic> _weatherData;

  @override
  void initState() {
    super.initState();
    _weatherData = <String, dynamic>{};
  }

  Future<void> _fetchWeatherData(String city) async {
    try {
      final weatherData = await _weatherService.getWeather(city);
      setState(() {
        _weatherData = weatherData as Map<String, dynamic>;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo Weather-API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder(
            future: _fetchWeatherData("Limeira"),
            builder: (context, snapshot) {
              if (_weatherData.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('City: ${_weatherData['name']}'),
                      Text('Temperature: ${_weatherData['main']['temp'] -273} ºC'),
                      Text('Description: ${_weatherData['weather'][0]['description']}'),
                      Text('Pressure: ${_weatherData['main']['pressure']}'),
                      Text('Humidity: ${_weatherData['main']['humidity']}'),
                      Text('Wind: ${_weatherData['wind']['speed']}'),
                      Text('Wind Direction: ${_weatherData['wind']['deg']}'), 
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
