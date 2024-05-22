import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';

class DetailsWeatherScreen extends StatefulWidget {
  const DetailsWeatherScreen({super.key});

  @override
  State<DetailsWeatherScreen> createState() => _DetailsWeatherScreenState();
}

class _DetailsWeatherScreenState extends State<DetailsWeatherScreen> {
  final WeatherController _controller = WeatherController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    _controller.weatherList.last.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.yellow,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Text(
                _controller.weatherList.last.main,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _controller.weatherList.last.description,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (_controller.weatherList.last.temp - 273).toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (_controller.weatherList.last.tempMax - 273).toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (_controller.weatherList.last.tempMin - 273).toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (_controller.weatherList.last.preassure).toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (_controller.weatherList.last.humidity).toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (_controller.weatherList.last.seaLevel).toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (_controller.weatherList.last.grndLevel).toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (_controller.weatherList.last.feelsLike).toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
