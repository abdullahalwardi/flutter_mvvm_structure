import 'package:flutter/material.dart';

class FilledLoadingButton extends StatelessWidget {
  const FilledLoadingButton({
    super.key,
    required this.isLoading,
    required this.child,
    required this.onPressed,
  });

  final bool isLoading;
  final Widget child;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? const CircularProgressIndicator() : child,
    );
  }
}
