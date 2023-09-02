import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';

class SelectableButton extends StatelessWidget {
  const SelectableButton(
      {super.key, required this.onPressed, required this.label, required this.isSelected});

  final VoidCallback onPressed;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderSize.extraLarge),
        ),
        side: BorderSide(
          color: context.colorScheme.primary,
          width: 1,
        ),
        padding: const EdgeInsets.symmetric(horizontal: Insets.small),
        backgroundColor: isSelected ? context.colorScheme.primary : null,
        foregroundColor: isSelected ? context.colorScheme.onPrimary : null,
      ),
      child: Text(label),
    );
  }
}
