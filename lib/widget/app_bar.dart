import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrc/main.dart';
import 'package:qrc/theme.dart';

class AppBarTitle extends StatefulWidget {
  bool showHomeButton;
  AppBarTitle({super.key, required this.showHomeButton});

  @override
  State<AppBarTitle> createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.showHomeButton) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, "/");
                      },
                      label: Text("Accueil", style: adapteText(context)),
                      icon: Icon(Icons.home),
                    ),
                  ),
                ],
              ),
            ],

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
