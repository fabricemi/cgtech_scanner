import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrc/theme.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton.filled(
        onPressed: () {
          theme.changeMode(!theme.isDark);
        },
        icon: Icon(
          theme.isDark ? Icons.dark_mode : Icons.light_mode,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
