import 'package:flutter/material.dart';

class Volume extends StatelessWidget {
  const Volume({
    super.key,
    required this.volume,
    required this.onChanged,
  });

  final double volume;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Volume', style: TextStyle(color: Colors.white)),
        Slider(
          value: volume,
          min: 0.0,
          max: 1.0,
          activeColor: Colors.green,
          inactiveColor: Colors.white54,
          onChanged: onChanged,
        ),
        Text('${(volume * 100).toInt()}%',
            style: const TextStyle(color: Colors.white54)),
      ],
    );
  }
}
