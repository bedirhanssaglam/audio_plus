import 'package:flutter/material.dart';

class SongInfo extends StatelessWidget {
  const SongInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Beethoven - Für Elise',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(
          'Ludwig van Beethoven',
          style: TextStyle(color: Colors.white54, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
