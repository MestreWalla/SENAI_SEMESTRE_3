import 'dart:core';

import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Model/city_model.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';
import 'package:projeto_api_geo/View/details_weather_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherController _controller = WeatherController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();
  final CityDbService _dbService = CityDbService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pesquisa por cidade",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Digite a cidade",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        gapPadding: 12,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF2F2F2),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      prefixIcon: Icon(Icons.location_city),
                    ),
                    controller: _cityController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Campo cidade obrigatório";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _findByCity(_cityController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Pesquisar"),
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<List<City>>(
                    future: _dbService.getAllCities(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Erro ao carregar histórico de pesquisa"),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text("Sem histórico de pesquisa"),
                        );
                      } else {
                        return SizedBox(
                          height: 200, // Altura máxima para a lista
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final city = snapshot.data![index];
                              return ListTile(
                                title: Text(city.cityName),
                                onTap: () {
                                  _findByCity(city.cityName);
                                },
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _findByCity(String city) async {
    if (await _controller.findCity(city)) {
      //snackbar
      City cidade = City(cityName: city, favoriteCities: false);
      _dbService.insertCity(cidade);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cidade encontrada!"),
          duration: Duration(seconds: 1),
        ),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  DetailsWeatherScreen(city: city)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Cidade não encontrada!"),
        duration: Duration(seconds: 1),
      ));
    }
  }
}
