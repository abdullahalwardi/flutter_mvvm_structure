
import 'package:flutter/material.dart';

class IconLoadingButton extends StatelessWidget {
  const IconLoadingButton({
    super.key,
    required this.isLoading,
    required this.child,
    required this.onPressed,
  });

  final bool isLoading;
  final Widget child;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading ? const CircularProgressIndicator() : child,
    );
  }
}