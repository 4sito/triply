// theme_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final seedColorProvider =
    AsyncNotifierProvider<SeedColorNotifier, Color>(SeedColorNotifier.new);

class SeedColorNotifier extends AsyncNotifier<Color> {
  static const _key = 'seed_color';

  @override
  Future<Color> build() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(_key);
    return value != null ? Color(value) : Colors.teal;
  }

  Future<void> setColor(Color color) async {
    state = AsyncValue.data(color);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, color.toARGB32());
  }
}



final themeModeProvider =
    AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class ThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  static const _key = 'theme_mode';

  @override
  Future<ThemeMode> build() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_key);
    return _parse(stored) ?? ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = AsyncValue.data(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }

  ThemeMode? _parse(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }
}
