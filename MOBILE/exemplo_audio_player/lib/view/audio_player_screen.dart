// ignore_for_file: unnecessary_null_comparison

import 'package:exemplo_audio_player/services/audio_service.dart';
import 'package:exemplo_audio_player/model/audio_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioService _service = AudioService();
  AudioModel? _currentlyPlaying;
  bool _isLoading = true;
  bool _isPlaying = false;
  late AudioPlayer _audioPlayer;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  Future<void> _getAudioList() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _service.fetchAudio();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });
    _getAudioList();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(UrlSource(_currentlyPlaying!.url));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _playPrevious() {
    if (_currentlyPlaying != null) {
      final currentIndex = _service.list.indexOf(_currentlyPlaying!);
      if (currentIndex > 0) {
        final previousAudio = _service.list[currentIndex - 1];
        _playAudio(previousAudio);
      }
    }
  }

  void _playNext() {
    if (_currentlyPlaying != null) {
      final currentIndex = _service.list.indexOf(_currentlyPlaying!);
      if (currentIndex < _service.list.length - 1) {
        final nextAudio = _service.list[currentIndex + 1];
        _playAudio(nextAudio);
      }
    }
  }

  void _playAudio(AudioModel audio) {
    _audioPlayer.play(UrlSource(audio.url));
    setState(() {
      _currentlyPlaying = audio;
      _isPlaying = true;
      _currentPosition = Duration.zero;
      _totalDuration = Duration.zero;
    });
  }

  void _seek(double value) {
    final position = Duration(seconds: value.toInt());
    _audioPlayer.seek(position);
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getAudioList,
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _service.list.isEmpty
                    ? const Center(
                        child: Text('Não há músicas disponíveis'),
                      )
                    : ListView.builder(
                        itemCount: _service.list.length,
                        itemBuilder: (context, index) {
                          final audio = _service.list[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: audio.albumarturl != null
                                  ? Image.network(
                                      audio.albumarturl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.music_note, size: 50),
                                    )
                                  : const Icon(Icons.music_note, size: 50),
                              title: Text(audio.title),
                              subtitle: Text(audio.artist),
                              trailing: const Icon(Icons.play_arrow),
                              onTap: () {
                                _playAudio(audio);
                              },
                            ),
                          );
                        },
                      ),
          ),
          if (_currentlyPlaying != null)
            DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.1,
              maxChildSize: 1.0,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.0, -2.0),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            if (_currentlyPlaying!.albumarturl != null)
                              Image.network(
                                _currentlyPlaying!.albumarturl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.music_note, size: 50),
                              )
                            else
                              const Icon(Icons.music_note, size: 50),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _currentlyPlaying!.title,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    _currentlyPlaying!.artist,
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.skip_previous),
                              onPressed: _playPrevious,
                            ),
                            IconButton(
                              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                              onPressed: _playPause,
                            ),
                            IconButton(
                              icon: const Icon(Icons.skip_next),
                              onPressed: _playNext,
                            ),
                          ],
                        ),
                        Slider(
                          value: _currentPosition.inSeconds.toDouble(),
                          max: _totalDuration.inSeconds.toDouble(),
                          onChanged: _seek,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_formatDuration(_currentPosition)),
                            Text(_formatDuration(_totalDuration)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
