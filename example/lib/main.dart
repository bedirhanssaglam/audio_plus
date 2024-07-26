import 'dart:async';
import 'dart:io';

import 'package:audio_plus/audio_plus.dart';
import 'package:audio_plus_example/extension/format_extension.dart';
import 'package:audio_plus_example/widgets/album_art.dart';
import 'package:audio_plus_example/widgets/audio_appbar.dart';
import 'package:audio_plus_example/widgets/song_info.dart';
import 'package:audio_plus_example/widgets/volume.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AudioPlayerScreen(),
    );
  }
}

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final StreamController<double> _positionStreamController =
      StreamController<double>();
  bool isPlaying = false;
  bool isLooping = false;
  double currentPosition = 0;
  double maxDuration = 0;
  double volume = 1.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    maxDuration = await AudioPlus.duration ?? 0;
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    _positionStreamController.close();
    super.dispose();
  }

  Future<void> _play() async {
    await AudioPlus.play('assets/audio/beethoven.mp3');
    // or await AudioPlus.playUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
    maxDuration = await AudioPlus.duration ?? 0;
    currentPosition = await AudioPlus.currentPosition ?? 0;
    _startPositionStream();
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _stop() async {
    await AudioPlus.stop();
    setState(() {
      isPlaying = false;
      currentPosition = 0.0;
    });
  }

  Future<void> _startPositionStream() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      try {
        currentPosition = await AudioPlus.currentPosition ?? 0;
        _positionStreamController.add(currentPosition);
        bool? playing = await AudioPlus.isPlaying;
        setState(() {
          isPlaying = playing ?? false;
        });
      } catch (e) {
        _positionStreamController.addError(e);
      }
    });
  }

  Future<void> _pause() async {
    await AudioPlus.pause();
    setState(() {
      isPlaying = false;
    });
  }

  Future<void> _resume() async {
    await AudioPlus.resume();
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _seekTo(double value) async {
    await AudioPlus.seekTo(
        ((Platform.isAndroid ? value * 1000 : value).toInt()));
    setState(() {
      currentPosition = value;
    });
  }

  Future<void> _changeVolume(double value) async {
    await AudioPlus.increaseVolume(value);
    setState(() {
      volume = value;
    });
  }

  Future<void> _setReplay() async {
    isLooping = !isLooping;
    await AudioPlus.isLooping(isLooping);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const AudioAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const AlbumArt(),
            const SongInfo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: StreamBuilder<double>(
                    stream: _positionStreamController.stream,
                    builder: (context, snapshot) {
                      return Text(
                        (snapshot.data ?? 0).formatDuration,
                        style: const TextStyle(color: Colors.white54),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: currentPosition,
                    min: 0.0,
                    max: maxDuration,
                    activeColor: Colors.green,
                    inactiveColor: Colors.white54,
                    onChanged: _seekTo,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    maxDuration.formatDuration,
                    style: const TextStyle(color: Colors.white54),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    color: Colors.white,
                    size: 56,
                  ),
                  onPressed: isPlaying
                      ? _pause
                      : currentPosition > 0
                          ? _resume
                          : () => _play,
                ),
                if (currentPosition > 0)
                  IconButton(
                    icon: const Icon(
                      Icons.stop_circle_outlined,
                      color: Colors.red,
                      size: 56,
                    ),
                    onPressed: _stop,
                  ),
                IconButton(
                  icon: Icon(
                    isLooping ? Icons.repeat_one : Icons.repeat,
                    color: isLooping ? Colors.green : Colors.white,
                    size: 56,
                  ),
                  onPressed: _setReplay,
                ),
              ],
            ),
            Volume(volume: volume, onChanged: _changeVolume),
          ],
        ),
      ),
    );
  }
}
