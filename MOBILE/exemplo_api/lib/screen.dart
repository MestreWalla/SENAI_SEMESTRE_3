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
        'b9ebe666087f299f5e2aad3a03d093b6', // Chave de API para acesso à API de previsão do tempo.
    baseUrl:
        'https://api.openweathermap.org/data/2.5', // URL base da API de previsão do tempo.
  );

  // Mapa que armazenará os dados de previsão do tempo.
  late Map<String, dynamic> _weatherData;
  TextEditingController _cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
        child: Center(
          child: Form(
              child: Column(children: [
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(label: "Digite a cidade: "),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "insira uma cidade";
                }
              },
            )
          ])),
        ),
      ),
    );
  }
}
