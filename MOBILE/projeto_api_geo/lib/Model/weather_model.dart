class Weather {
  final String name;
  final String main;
  final String description;
  final double temp;
  final double tempMin;
  final double tempMax;
  final int preassure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;
  final double feelsLike;

  //construtor
  Weather({
    required this.name,
    required this.main,
    required this.description,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.preassure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
    required this.feelsLike,
  });

  //Fron Factory
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['name'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temp: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      preassure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      seaLevel: json['main']['sea_level'],
      grndLevel: json['main']['grnd_level'],
      feelsLike: json['main']['feels_like'],
    );
  }
}
