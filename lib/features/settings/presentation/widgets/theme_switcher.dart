import 'package:currensee/features/settings/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return SwitchListTile(
      title: const Text('Dark Mode'),
      // The icon can change based on the theme
      secondary: Icon(
          themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
      value: themeMode == ThemeMode.dark,
      onChanged: (isDark) {
        ref
            .read(themeModeProvider.notifier)
            .setTheme(isDark ? ThemeMode.dark : ThemeMode.light);
      },
    );
  }
}
