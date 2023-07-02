import 'package:app/common_lib.dart';
import 'package:app/data/providers/settings_provider.dart';
import 'package:app/theme/theme_mode.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void _switchThemeMode() {
    ref.read(settingsProvider.notifier).toggleThemeMode(context);
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
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton.icon(
              onPressed: () => Future.sync(() => ref
                  .read(settingsProvider.notifier)
                  .setLocale(settings.locale?.languageCode == 'en'
                      ? const Locale('es')
                      : const Locale('en'))),
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
