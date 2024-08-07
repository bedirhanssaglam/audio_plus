library audio_plus;

import 'package:audio_plus/src/audio_plus_platform_interface.dart';

/// This class provides a unified interface for audio playback operations,
/// abstracting away platform-specific implementations.
class AudioPlus {
  /// Initiates audio playback for the specified file.
  ///
  /// This method sends a request to the platform to play the audio file located
  /// at the given [filePath].
  static Future<void> play(String filePath) async =>
      AudioPlusPlatform.instance.play(filePath);

  /// Initiates audio playback for the specified URL.
  ///
  /// This method sends a request to the platform to play the audio file from
  /// the given [url].
  static Future<void> playUrl(String url) async =>
      AudioPlusPlatform.instance.playUrl(url);

  /// Pauses the currently playing audio.
  ///
  /// This method sends a request to the platform to pause the currently
  /// playing audio, if any.
  static Future<void> pause() async => AudioPlusPlatform.instance.pause();

  /// Resumes the paused audio playback.
  ///
  /// This method sends a request to the platform to resume audio playback from
  /// the position where it was paused.
  static Future<void> resume() async => AudioPlusPlatform.instance.resume();

  /// Stops the audio playback.
  ///
  /// This method sends a request to the platform to stop the audio playback
  /// completely.
  static Future<void> stop() async => AudioPlusPlatform.instance.stop();

  /// Increases the volume of the audio.
  ///
  /// This method sends a request to the platform to increase the volume
  /// of the currently playing audio to the specified [volume] level.
  static Future<void> increaseVolume(double volume) async =>
      AudioPlusPlatform.instance.increaseVolume(volume);

  /// Seeks to the specified position in the audio playback.
  ///
  /// This method sends a request to the platform to seek to the specified
  /// [position] in the currently playing audio.
  static Future<void> seekTo(int position) async =>
      AudioPlusPlatform.instance.seekTo(position);

  /// Checks whether audio is currently playing.
  ///
  /// This method sends a request to the platform to determine whether audio
  /// is currently being played.
  static Future<bool?> get isPlaying async =>
      AudioPlusPlatform.instance.isPlaying;

  /// Retrieves the current playback position of the audio.
  ///
  /// This method sends a request to the platform to retrieve the current
  /// playback position of the currently playing audio.
  static Future<double?> get currentPosition async =>
      AudioPlusPlatform.instance.currentPosition;

  /// Retrieves the total duration of the audio.
  ///
  /// This method sends a request to the platform to retrieve the total duration
  /// of the currently playing audio.
  static Future<double?> get duration async =>
      AudioPlusPlatform.instance.duration;

  /// Sets the replay mode of the audio.
  ///
  /// This method sends a request to the platform to set whether the currently playing
  /// audio should replay automatically when it reaches the end. If [isLooping] is `true`,
  /// the audio will replay indefinitely. If [isLooping] is `false`, the audio will play once
  /// and then stop.
  ///
  /// * [isLooping]: A boolean value indicating whether the audio should replay.
  static Future<void> isLooping(bool isLooping) async =>
      AudioPlusPlatform.instance.isLooping(isLooping);
}
