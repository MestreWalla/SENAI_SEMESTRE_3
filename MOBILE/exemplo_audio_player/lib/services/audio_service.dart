import 'dart:convert';

import 'package:exemplo_audio_player/model/audio_model.dart';
import 'package:http/http.dart' as http;

class AudioService {
  List<AudioModel> _list = [];
  List<AudioModel> get list => _list;

  //url da api
  final String url = 'http://172.27.48.1:3000/audio';

  //fetch da lista de audio
  Future<void> fetchAudio() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _list.clear();
      _list = data.map((e) => AudioModel.fromMap(e)).toList();
    }
  }
}
