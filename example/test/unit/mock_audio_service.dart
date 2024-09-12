import 'audio_service.dart';

class MockAudioService implements AudioService {
  bool _isPlaying = false;
  final int _duration = 240000;
  int _position = 0;

  @override
  Future<void> play(String path) async {
    _isPlaying = true;
    _position = 0;
  }

  @override
  Future<void> stop() async {
    _isPlaying = false;
    _position = 0;
  }

  @override
  Future<void> pause() async {
    _isPlaying = false;
  }

  @override
  Future<void> resume() async {
    _isPlaying = true;
  }

  @override
  Future<void> seekTo(int position) async {
    _position = position;
  }

  @override
  Future<void> increaseVolume(double value) async {}

  @override
  Future<int?> get duration async => _duration;

  @override
  Future<int?> get currentPosition async => _position;

  @override
  Future<bool?> get isPlaying async => _isPlaying;

  @override
  Future<void> setLooping(bool loop) async {}
}
