import 'package:flutter/material.dart';

class DislikedIcon extends StatelessWidget {
  const DislikedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -15,
      left: -35,
      child: MaterialButton(
        onPressed: (() {}),
        color: Colors.red,
        textColor: Colors.white,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(5),
        child: const Icon(Icons.thumb_down, size: 16),
      ),
    );
  }
}
