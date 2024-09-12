import 'package:flutter_test/flutter_test.dart';

import 'mock_audio_service.dart';

void main() {
  late MockAudioService mockAudioService;

  setUp(() {
    mockAudioService = MockAudioService();
  });

  test('AudioPlayer can play and stop correctly', () async {
    await mockAudioService.play('assets/audio/test.mp3');
    expect(await mockAudioService.isPlaying, true);

    await mockAudioService.stop();
    expect(await mockAudioService.isPlaying, false);
  });

  test('AudioPlayer can seek to a specific position', () async {
    await mockAudioService.seekTo(60000); // 1 min
    expect(await mockAudioService.currentPosition, 60000);
  });

  test('AudioPlayer can change volume', () async {
    await mockAudioService.increaseVolume(0.5);
  });
}
