class AudioModel {
  //atributos
  final String title;
  final String artist;
  final String url;
  final String albumarturl;

  AudioModel({required this.title, required this.artist, required this.url, required this.albumarturl});

  //fromMap
  factory AudioModel.fromMap(Map<String, dynamic> map) {
    return AudioModel(
      title: map['title'],
      artist: map['artist'],
      url: map['url'],
      albumarturl: map['url'],
    );
  }
}
