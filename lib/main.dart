import 'package:flutter/material.dart';
import 'package:flutter_text_scaling_example/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final textScale = ref.watch(scaleProvider);
        return MaterialApp(
          builder: (context, widgetChild) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(textScaler: TextScaler.linear(textScale)),
              child: widgetChild!,
            );
          },
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      },
    );
  }
}

/// Created a StateProvider to manage the text scaling changes
final scaleProvider = StateProvider((ref) => 1.0);
