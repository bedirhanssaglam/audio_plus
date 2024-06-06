import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'audio_plus_method_channel.dart';

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

  Future<void> play(String filePath);
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
  Future<void> increaseVolume(double volume);
  Future<void> seekTo(int position);
  Future<bool?> get isPlaying;
  Future<double?> get currentPosition;
  Future<double?> get duration;
}
