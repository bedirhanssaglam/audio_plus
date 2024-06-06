import 'package:flutter/material.dart';

class AudioAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AudioAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text('Now Playing', style: TextStyle(color: Colors.white)),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
