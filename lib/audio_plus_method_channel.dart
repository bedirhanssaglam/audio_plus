import 'dart:async' show Future;
import 'dart:developer' show log;
import 'dart:io' show File;

import 'package:flutter/foundation.dart' show ByteData, visibleForTesting;
import 'package:flutter/services.dart'
    show ByteData, MethodChannel, PlatformException, rootBundle;
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;

import 'audio_plus_platform_interface.dart';

/// An implementation of [AudioPlusPlatform] that uses method channels.
class MethodChannelAudioPlus extends AudioPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('audio_plus');

  Future<String> _getTempFilePath(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    final String tempPath = (await getTemporaryDirectory()).path;
    final File tempFile = File('$tempPath/${assetPath.split('/').last}');
    await tempFile.writeAsBytes(bytes, flush: true);
    return tempFile.path;
  }

  @override
  Future<void> play(String filePath) async {
    try {
      final path = await _getTempFilePath(filePath);
      await methodChannel.invokeMethod('play', {'filePath': path});
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> pause() async {
    try {
      await methodChannel.invokeMethod('pause');
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> resume() async {
    try {
      await methodChannel.invokeMethod('resume');
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> stop() async {
    try {
      await methodChannel.invokeMethod('stop');
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> increaseVolume(double volume) async {
    try {
      await methodChannel.invokeMethod('increaseVolume', {'volume': volume});
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> seekTo(int position) async {
    try {
      await methodChannel.invokeMethod('seekTo', {'position': position});
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    }
  }

  @override
  Future<bool?> get isPlaying async {
    try {
      return await methodChannel.invokeMethod<bool>('isPlaying') ?? false;
    } on PlatformException catch (e) {
      log("Failed to seekTo: '${e.message}'.");
      return null;
    }
  }

  @override
  Future<double?> get currentPosition async {
    try {
      return await methodChannel.invokeMethod<double>('currentPosition') ?? 0;
    } on PlatformException catch (e) {
      log("Failed to seekTo: '${e.message}'.");
      return null;
    }
  }

  @override
  Future<double?> get duration async {
    try {
      return await methodChannel.invokeMethod<double>('getDuration') ?? 0;
    } on PlatformException catch (e) {
      log("Failed to seekTo: '${e.message}'.");
      return null;
    }
  }
}
