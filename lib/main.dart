import 'package:flutter/material.dart';
import 'package:flutter_text_scaling_example/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final textScale = prefs.getDouble("textScale");
  print(textScale);
  runApp(ProviderScope(child: MyApp(textScaleVal: textScale??0,)));
}

class MyApp extends StatelessWidget {
  final double textScaleVal;
   MyApp({super.key,required this.textScaleVal});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final textScale = ref.watch(scaleProvider);
        /// Schedule state update after widget tree is built
        Future.microtask(()async {
         if(textScaleVal == 0){
           ref.read(scaleProvider.notifier).update((ref)=>1.0);
         }else{
           final SharedPreferences prefs = await SharedPreferences.getInstance();
           final textSize = prefs.getDouble("textScale");
           ref.read(scaleProvider.notifier).update((ref)=>textSize!);

         }
        });
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
