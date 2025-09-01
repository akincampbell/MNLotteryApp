import 'package:flutter/material.dart';

class DemoRibbon extends StatelessWidget {
  const DemoRibbon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12,
      left: -36,
      child: Transform.rotate(
        angle: -0.7,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          color: const Color(0xFFD2E101),
          child: const Text(
            'DEMO',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
