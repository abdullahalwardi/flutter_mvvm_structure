import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';

class SvgPrefixIcon extends StatelessWidget {
  const SvgPrefixIcon({
    super.key,
    required this.svgPath,
  });

  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.medium),
      child: SvgPicture.asset(
        svgPath,
        color: context.colorScheme.primary,
        width: 24,
      ),
    );
  }
}
