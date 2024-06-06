extension FormatExtension on double {
  String get formatDuration {
    final int minutes = (this / 60).floor();
    final int seconds = (this % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
