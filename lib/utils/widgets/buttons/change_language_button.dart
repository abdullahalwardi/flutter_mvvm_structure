
import 'package:app/common_lib.dart';
import 'package:app/data/providers/settings_provider.dart';
import 'package:flutter/material.dart';

class ChangeLanguageButton extends HookConsumerWidget {
  const ChangeLanguageButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return DropdownButton(
                value: settings.localeCode ?? 'en',
                onChanged: (value) {
                  if (value != null) {
                    ref
                        .read(settingsProvider.notifier)
                        .setLocale(Locale(value));
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text("English"),
                  ),
                  DropdownMenuItem(
                    value: 'ar',
                    child: Text("العربية"),
                  ),
                ],
                icon: const Icon(Icons.language_outlined),
                underline: const SizedBox(),
              );
  }
}