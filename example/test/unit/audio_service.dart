abstract class AudioService {
  Future<void> play(String path);
  Future<void> stop();
  Future<void> pause();
  Future<void> resume();
  Future<void> seekTo(int position);
  Future<void> increaseVolume(double value);
  Future<int?> get duration;
  Future<int?> get currentPosition;
  Future<bool?> get isPlaying;
  Future<void> setLooping(bool loop);
}
