import 'package:flutter/material.dart';
import 'package:flutter_text_scaling_example/screens/home_screen.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

/// Created a StateProvider to manage the text scaling changes
final scaleProvider = StateProvider((ref) => 1);
