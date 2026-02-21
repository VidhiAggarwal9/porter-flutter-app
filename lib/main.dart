import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const PorterApp());
}

class PorterApp extends StatelessWidget {
  const PorterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
