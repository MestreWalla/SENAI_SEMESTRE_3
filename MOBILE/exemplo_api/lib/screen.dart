import 'package:exemplo_api/sevice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService(
    apiKey: 'b9ebe666087f299f5e2aad3a03d093b6',
    baseUrl: 'https://api.openweathermap.org/data/2.5',
  );

  late Map<String, dynamic> _weatherData;
  final TextEditingController _cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _weatherData = new Map<String, dynamic>();
  }

  Future<void> _fetchWeatherData(String city) async {
    try {
      final weatherData = await _weatherService.getWeather(city);
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _fetchWeatherLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final weatherData = await _weatherService.getWeatherByLocation(
          position.latitude, position.longitude);
      setState(() {
        _weatherData = weatherData;
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
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: _fetchWeatherLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os dados.'));
          } else if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('city: ${_weatherData['name']}',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  Text('Temperature: ${(_weatherData['main']['temp']).toInt - 273} ºC',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Text('Description: ${_weatherData['weather'][0]['description']}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Nenhum dado disponível.'));
          }
        },
      ),
    ),
  );
}

}
