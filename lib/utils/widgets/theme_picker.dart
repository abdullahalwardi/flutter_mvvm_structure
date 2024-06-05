import 'package:app/common_lib.dart';
import 'package:app/data/providers/settings_provider.dart';
import 'package:flutter/material.dart';


Future showThemePickerDialog({required WidgetRef ref}) {
  final themeMode = ref.watch(settingsProvider).themeMode;

  final context = ref.context;

  final themes = <({
    String name,
    Widget widget,
    ThemeMode mode,
  })>[
    (
      name: context.l10n.themeSystem,
      widget: const Icon(Icons.settings_suggest),
      mode: ThemeMode.system,
    ),
    (
      name: context.l10n.themeLight,
      widget: const Icon(Icons.light_mode),
      mode: ThemeMode.light,
    ),
    (
      name: context.l10n.themeDark,
      widget: const Icon(Icons.dark_mode),
      mode: ThemeMode.dark,
    ),
  ];

  return showDialog(
    context: ref.context,
    builder: (context) {
      return AlertDialog(
        title: Text(context.l10n.theme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final theme in themes)
              RadioListTile<ThemeMode>(
                title: RowPadded(
                  children: [
                    theme.widget,
                    Expanded(child: Text(theme.name)),
                  ],
                ),
                value: theme.mode,
                groupValue: themeMode,
                onChanged: (ThemeMode? value) {
                  ref
                      .read(settingsProvider.notifier)
                      .update((state) => state.copyWith(themeMode: value!));
                  context.pop();
                },
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(context.l10n.cancel),
          ),
        ],
      );
    },
  );
}
