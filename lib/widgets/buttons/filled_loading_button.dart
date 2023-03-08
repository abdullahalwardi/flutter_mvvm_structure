import 'package:app/utils/extensions.dart';
import 'package:flutter/material.dart';

class FilledLoadingButton extends StatefulWidget {
  const FilledLoadingButton(
      {super.key, required this.onPressed, this.isLoading = false, required this.child});

  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget child;

  @override
  State<FilledLoadingButton> createState() => _FilledLoadingButtonState();
}

class _FilledLoadingButtonState extends State<FilledLoadingButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: widget.onPressed,
        child: widget.isLoading
            ?  CircularProgressIndicator(color: context.colorScheme.onPrimary,)
            : widget.child,
            );
  }
}
