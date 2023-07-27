import 'package:flutter/material.dart';

class OutlinedLoadingButton extends StatelessWidget {
  const OutlinedLoadingButton({
    super.key,
    required this.isLoading,
    required this.child,
    required this.onPressed,
    this.progressIndicatorColor
  });

  final bool isLoading;
  final Widget child;
  final Color? progressIndicatorColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? CircularProgressIndicator(color: progressIndicatorColor) : child,
    );
  }
}
