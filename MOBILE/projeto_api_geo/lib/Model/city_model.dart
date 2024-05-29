class City {
  final String cityName;
  final int favoriteCities;

  // Construtor
  City({required this.cityName, required this.favoriteCities});

  // Método toMap
  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'favoriteCities': favoriteCities,
    };
  }

  // Construtor fromMap
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      cityName: map['cityname'],
      favoriteCities: map['favoritecities'],
    );
  }
}
// 26/02