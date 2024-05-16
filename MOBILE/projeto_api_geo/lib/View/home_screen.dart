import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_api_geo/Service/weather_service_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> _weatherData = {};
  final WeatherService _weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o serviço de localização está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (kDebugMode) {
        print('Serviço de localização está desativado.');
      }
      return;
    }

    // Verifica se a permissão foi concedida
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (kDebugMode) {
          print('Permissão de localização negada.');
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (kDebugMode) {
        print('Permissão de localização negada permanentemente.');
      }
      return;
    }

    // Se a permissão foi concedida, busca a localização
    _getWeatherInit();
  }

  Future<void> _getWeatherInit() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      final weatherData = await _weatherService.getWeatherByLocation(
        position.latitude,
        position.longitude,
      );
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
        title: const Text('Previsão do tempo'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Pesquisar"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Favoritos"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _weatherData.isEmpty
                ? Row(
                    children: [
                      const Text("Erro de conexão"),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: _getWeatherInit,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        _weatherData["name"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _weatherData["weather"][0]["description"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _weatherData["main"]["temp"].toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _weatherData["weather"][0]["icon"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
