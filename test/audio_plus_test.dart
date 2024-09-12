import 'package:audio_plus/src/audio_plus_method_channel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('audio_plus');
  final methodChannelAudioPlus = MethodChannelAudioPlus();

  setUp(() {
    // Kanalı test etmeden önce resetle
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return null;
    });
  });

  tearDown(() {
    // Test sonrası mock method çağrısını temizle
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('playUrl method is called with correct url', () async {
    String testUrl = 'https://example.com/audio.mp3';
    bool methodCalled = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'playUrl') {
        methodCalled = true;
        expect(methodCall.arguments['url'], testUrl);
      }
      return null;
    });

    await methodChannelAudioPlus.playUrl(testUrl);
    expect(methodCalled, isTrue);
  });

  test('pause method is called', () async {
    bool methodCalled = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'pause') {
        methodCalled = true;
      }
      return null;
    });

    await methodChannelAudioPlus.pause();
    expect(methodCalled, isTrue);
  });

  test('resume method is called', () async {
    bool methodCalled = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'resume') {
        methodCalled = true;
      }
      return null;
    });

    await methodChannelAudioPlus.resume();
    expect(methodCalled, isTrue);
  });

  test('stop method is called', () async {
    bool methodCalled = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'stop') {
        methodCalled = true;
      }
      return null;
    });

    await methodChannelAudioPlus.stop();
    expect(methodCalled, isTrue);
  });

  test('increaseVolume method is called with correct volume', () async {
    double testVolume = 0.8;
    bool methodCalled = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'increaseVolume') {
        methodCalled = true;
        expect(methodCall.arguments['volume'], testVolume);
      }
      return null;
    });

    await methodChannelAudioPlus.increaseVolume(testVolume);
    expect(methodCalled, isTrue);
  });

  test('seekTo method is called with correct position', () async {
    int testPosition = 5000;
    bool methodCalled = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'seekTo') {
        methodCalled = true;
        expect(methodCall.arguments['position'], testPosition);
      }
      return null;
    });

    await methodChannelAudioPlus.seekTo(testPosition);
    expect(methodCalled, isTrue);
  });

  test('isPlaying method returns correct value', () async {
    bool expectedIsPlaying = true;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'isPlaying') {
        return expectedIsPlaying;
      }
      return null;
    });

    final result = await methodChannelAudioPlus.isPlaying;
    expect(result, expectedIsPlaying);
  });

  test('currentPosition method returns correct value', () async {
    double expectedPosition = 120.5;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'currentPosition') {
        return expectedPosition;
      }
      return null;
    });

    final result = await methodChannelAudioPlus.currentPosition;
    expect(result, expectedPosition);
  });

  test('duration method returns correct value', () async {
    double expectedDuration = 300.0;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'getDuration') {
        return expectedDuration;
      }
      return null;
    });

    final result = await methodChannelAudioPlus.duration;
    expect(result, expectedDuration);
  });

  test('isLooping method is called with correct value', () async {
    bool testIsLooping = true;
    bool methodCalled = false;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'isLooping') {
        methodCalled = true;
        expect(methodCall.arguments['isLooping'], testIsLooping);
      }
      return null;
    });

    await methodChannelAudioPlus.isLooping(testIsLooping);
    expect(methodCalled, isTrue);
  });
}
