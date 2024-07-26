import 'package:flutter/material.dart';

class LikedIcon extends StatelessWidget {
  const LikedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -15,
      left: -35,
      child: MaterialButton(
        onPressed: (() {}),
        color: Colors.green,
        textColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(5),
        child: const Icon(Icons.thumb_up, size: 16),
      ),
    );
  }
}
