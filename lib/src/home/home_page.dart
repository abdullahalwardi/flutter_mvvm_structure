import 'package:app/common_lib.dart';
import 'package:app/data/providers/settings_provider.dart';
import 'package:app/theme/theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void _switchThemeMode() {
    ref.read(settingsProvider.notifier).switchThemeMode(context);
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(context.l10n.appName),
            Text(
              settings.themeMode.localize(context),
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton.icon(
              onPressed: ref.read(settingsProvider.notifier).switchLocale,
              icon: const Icon(Icons.language),
              label: Text(context.l10n.localeName),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _switchThemeMode,
        tooltip: context.l10n.switchTheme,
        child: Icon(
          settings.themeMode.isDark ? Icons.light_mode : Icons.dark_mode,
        ),
      ),
    );
  }
}
