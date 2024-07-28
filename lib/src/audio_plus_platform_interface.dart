import 'package:audio_plus/src/audio_plus_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// `AudioPlusPlatform` abstract class provides an interface for
/// platform-specific implementations of audio playback operations.
abstract class AudioPlusPlatform extends PlatformInterface {
  /// Constructs a AudioPlusPlatform.
  AudioPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static AudioPlusPlatform _instance = MethodChannelAudioPlus();

  /// The default instance of [AudioPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelAudioPlus].
  static AudioPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AudioPlusPlatform] when
  /// they register themselves.
  static set instance(AudioPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Initiates audio playback for the specified file.
  ///
  /// This method sends a request to the platform to play the audio file located
  /// at the given [filePath].
  Future<void> play(String filePath);

  /// Initiates audio playback for the specified URL.
  ///
  /// This method sends a request to the platform to play the audio file from
  /// the given [url].
  Future<void> playUrl(String url);

  /// Pauses the currently playing audio.
  ///
  /// This method sends a request to the platform to pause the currently
  /// playing audio, if any.
  Future<void> pause();

  /// Resumes the paused audio playback.
  ///
  /// This method sends a request to the platform to resume audio playback from
  /// the position where it was paused.
  Future<void> resume();

  /// Stops the audio playback.
  ///
  /// This method sends a request to the platform to stop the audio playback
  /// completely.
  Future<void> stop();

  /// Increases the volume of the audio.
  ///
  /// This method sends a request to the platform to increase the volume
  /// of the currently playing audio to the specified [volume] level.
  Future<void> increaseVolume(double volume);

  /// Seeks to the specified position in the audio playback.
  ///
  /// This method sends a request to the platform to seek to the specified
  /// [position] in the currently playing audio.
  Future<void> seekTo(int position);

  /// Checks whether audio is currently playing.
  ///
  /// This method sends a request to the platform to determine whether audio
  /// is currently being played.
  Future<bool?> get isPlaying;

  /// Retrieves the current playback position of the audio.
  ///
  /// This method sends a request to the platform to retrieve the current
  /// playback position of the currently playing audio.
  Future<double?> get currentPosition;

  /// Retrieves the total duration of the audio.
  ///
  /// This method sends a request to the platform to retrieve the total duration
  /// of the currently playing audio.
  Future<double?> get duration;

  /// Sets the replay mode of the audio.
  ///
  /// This method sends a request to the platform to set whether the currently playing
  /// audio should replay automatically when it reaches the end. If [isLooping] is `true`,
  /// the audio will replay indefinitely. If [isLooping] is `false`, the audio will play once
  /// and then stop.
  ///
  /// * [isLooping]: A boolean value indicating whether the audio should replay.
  Future<void> isLooping(bool isLooping);
}
