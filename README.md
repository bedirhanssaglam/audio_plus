# audio_plus

`audio_plus` is a comprehensive package for playing audio files in Flutter applications. This package provides a platform-independent interface and can be used to perform basic operations such as playing, pausing, resuming, and stopping audio files on different platforms (iOS, Android). Additionally, it includes advanced features for enhanced audio control and customized audio experiences.

## Table of contents

- [Features](#features)

- [Screenshots](#screenshots)

- [Installation](#installation)

- [Usage](#usage)

- [Dart Version](#dart-version)

- [Issues](#issues)

- [Contribute](#contribute)

- [Author](#author)

- [License](#license)

### Features

- **Audio Control**: Play, pause, resume, stop audio files.
- **Volume Adjustment:**: Increase or decrease the volume as desired.
- **Seek Position**: Seek to a specific position within the audio file.
- **Playback Status Tracking**: Track whether audio is currently playing.
- **Duration and Position Information**: Retrieve the current playback position and total duration.

### Screenshots

<table>
    <tbody>
            <td align="center" style="background-color: white">
                <img src="https://github.com/bedirhanssaglam/audio_plus/assets/105479937/013860e0-d5f9-4412-b335-84c0136828ac" width=250" /></a>
            </td>
            <td align="center" style="background-color: white">
               <img src="https://github.com/bedirhanssaglam/audio_plus/assets/105479937/08d68652-d9ff-4eae-befb-5adead6b487e" width=200" /></a>
            </td>
    </tbody>
</table>

### Installation

To add the `audio_plus` package to your project, include the following line in the dependencies section of your `pubspec.yaml` file:

```yaml
dependencies:
  audio_plus: ^0.0.1
```  

Run the following command in the terminal to update your package dependencies:

```bash
flutter pub get
```

### Usage

```dart
import 'package:audio_plus/audio_plus.dart';

// Play an audio file
await AudioPlus.play('assets/audio/beethoven.mp3');

// Pause playback
await AudioPlus.pause();

// Resume playback
await AudioPlus.resume();

// Stop playback
await AudioPlus.stop();

// Increase the volume
await AudioPlus.increaseVolume(0.8);

// Seek to a specific position
await AudioPlus.seekTo(5000);

// Check if audio is currently playing
bool? playing = await AudioPlus.isPlaying;

// Get the current playback position
double? currentPosition = await AudioPlus.currentPosition;

// Get the total duration of the audio
double? duration = await AudioPlus.duration;
```

In the `example` folder, you will find a sample application demonstrating how to use the `audio_plus` package. This example app creates an audio player interface and performs basic audio control operations.

### Dart Version

```yaml
  sdk: '>=2.15.0 <4.0.0'
```

### Issues

Please file any issues, bugs, or feature requests as an issue on [GitHub](https://github.com/bedirhanssaglam/audio_plus/issues) page.

### Contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug, or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/bedirhanssaglam/audio_plus/pulls).

### Author

This social_sharing_plus plugin for Flutter is developed by [Bedirhan Sağlam](https://github.com/bedirhanssaglam). You can contact me at <bedirhansaglam270@gmail.com>

### License

MIT
