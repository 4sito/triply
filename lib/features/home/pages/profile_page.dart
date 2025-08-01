import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:triply/core/theme_controller.dart';
import '../../../abstraction/base_page.dart';

// profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedColorAsync = ref.watch(seedColorProvider);
    final themeModeAsync = ref.watch(themeModeProvider);

    final setColor = ref.read(seedColorProvider.notifier);
    final setMode = ref.read(themeModeProvider.notifier);

    if (seedColorAsync.isLoading || themeModeAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (seedColorAsync.hasError || themeModeAsync.hasError) {
      return const Center(child: Text('Error loading preferences'));
    }

    final currentColor = seedColorAsync.value!;
    final currentMode = themeModeAsync.value!;

    final brightness = Theme.of(context).brightness;

    final colorOptions = <Color>[
      Colors.teal,
      Colors.deepOrange,
      Colors.indigo,
      Colors.green,
      Colors.purple,
    ];

    final themeOptions = <ThemeMode, Icon>{
      ThemeMode.system: Icon(Icons.settings),
      ThemeMode.light: Icon(Icons.light_mode),
      ThemeMode.dark: Icon(Icons.dark_mode),
    };

    return BasePage(
      icon: Icons.person,
      iconOutlined: Icons.person_outline,
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Select App Theme Color:'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: colorOptions.map((color) {
                return GestureDetector(
                  onTap: () => setColor.setColor(color),
                  child: CircleAvatar(
                    backgroundColor: color,
                    radius: 24,
                    child: currentColor == color
                        ? Icon(
                            Icons.check,
                            color: brightness == Brightness.dark
                                ? Colors.black
                                : Colors.white,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            const Text('Select Theme Mode:'),
            Wrap(
              spacing: 12,
              children: themeOptions.entries.map((entry) {
                final isSelected = currentMode == entry.key;

                return Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.2)
                        : null,
                    borderRadius: BorderRadius.circular(8),
                    border: isSelected
                        ? Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          )
                        : null,
                  ),
                  child: IconButton(
                    onPressed: () => setMode.setThemeMode(entry.key),
                    icon: entry.value,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).iconTheme.color,
                    iconSize: 32,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
