import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triply/core/theme_controller.dart';
import 'features/home/home_screen.dart';

ThemeData buildTheme(Color seedColor, Brightness brightness) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    ),
    useMaterial3: true,
  );
}

class TriplyApp extends StatelessWidget {
  const TriplyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // main.dart
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, _) {
          final seedColorAsync = ref.watch(seedColorProvider);
          final themeModeAsync = ref.watch(themeModeProvider);

          if (seedColorAsync.isLoading || themeModeAsync.isLoading) {
            return const CircularProgressIndicator(); // or splash screen
          }
          final seedColor = seedColorAsync.value!;
          final themeMode = themeModeAsync.value!;
          return MaterialApp(
            title: 'Triply',
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: buildTheme(seedColor, Brightness.light),
            darkTheme: buildTheme(seedColor, Brightness.dark),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
