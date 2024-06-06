import 'audio_plus_platform_interface.dart';

/// This class provides a unified interface for audio playback operations,
/// abstracting away platform-specific implementations.
class AudioPlus {
  /// Initiates audio playback for the specified file.
  ///
  /// This method sends a request to the platform to play the audio file located
  /// at the given [filePath].
  static Future<void> play(String filePath) async =>
      await AudioPlusPlatform.instance.play(filePath);

  /// Pauses the currently playing audio.
  ///
  /// This method sends a request to the platform to pause the currently
  /// playing audio, if any.
  static Future<void> pause() async => await AudioPlusPlatform.instance.pause();

  /// Resumes the paused audio playback.
  ///
  /// This method sends a request to the platform to resume audio playback from
  /// the position where it was paused.
  static Future<void> resume() async =>
      await AudioPlusPlatform.instance.resume();

  /// Stops the audio playback.
  ///
  /// This method sends a request to the platform to stop the audio playback
  /// completely.
  static Future<void> stop() async => await AudioPlusPlatform.instance.stop();

  /// Increases the volume of the audio.
  ///
  /// This method sends a request to the platform to increase the volume
  /// of the currently playing audio to the specified [volume] level.
  static Future<void> increaseVolume(double volume) async =>
      await AudioPlusPlatform.instance.increaseVolume(volume);

  /// Seeks to the specified position in the audio playback.
  ///
  /// This method sends a request to the platform to seek to the specified
  /// [position] in the currently playing audio.
  static Future<void> seekTo(int position) async =>
      await AudioPlusPlatform.instance.seekTo(position);

  /// Checks whether audio is currently playing.
  ///
  /// This method sends a request to the platform to determine whether audio
  /// is currently being played.
  static Future<bool?> get isPlaying async =>
      await AudioPlusPlatform.instance.isPlaying;

  /// Retrieves the current playback position of the audio.
  ///
  /// This method sends a request to the platform to retrieve the current
  /// playback position of the currently playing audio.
  static Future<double?> get currentPosition async =>
      await AudioPlusPlatform.instance.currentPosition;

  /// Retrieves the total duration of the audio.
  ///
  /// This method sends a request to the platform to retrieve the total duration
  /// of the currently playing audio.
  static Future<double?> get duration async =>
      await AudioPlusPlatform.instance.duration;
}
