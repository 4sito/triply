import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final seedColorProvider = StateProvider<Color>((ref) => Colors.teal); 
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
