import 'package:app/common_lib.dart';
import 'package:app/utils/widgets/buttons/filled_loading_button.dart';
import 'package:flutter/material.dart';

class CustomDialog extends HookConsumerWidget {
  const CustomDialog({
    super.key,
    required this.children,
    required this.titleText,
    required this.isLoading,
    required this.onAdd,
  });
  final List<Widget> children;
  final String titleText;
  final bool isLoading;
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Insets.medium),
        child: ColumnPadded(
          crossAxisAlignment: CrossAxisAlignment.start,
          gap: Insets.medium,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              titleText,
              style: context.textTheme.titleLarge,
            ),
            ...children,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilledLoadingButton(
                  isLoading: isLoading,
                  onPressed: onAdd,
                  child: const Text("إضافة"),
                ),
                const Gap(Insets.small),
                FilledButton(
                  onPressed: context.pop,
                  style: FilledButton.styleFrom(
                      backgroundColor: context.colorScheme.error,
                      foregroundColor: context.colorScheme.onError),
                  child: const Text("الغاء"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
