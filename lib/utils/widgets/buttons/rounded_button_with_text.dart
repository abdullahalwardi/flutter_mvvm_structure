import 'package:app/common_lib.dart';
import 'package:app/utils/widgets/buttons/rounded_button.dart';
import 'package:flutter/material.dart';

class RoundedButtonWithText extends StatelessWidget {
  const RoundedButtonWithText({
    super.key,
    this.backgroundColor,
    this.iconColor,
    required this.onTap,
    required this.svgPath,
    required this.text,
    required this.textColor,
    this.size,
  });

  final Color? backgroundColor, textColor, iconColor;
  final String svgPath, text;
  final VoidCallback onTap;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedButton(
          backgroundColor: backgroundColor,
          size: size ?? 58,
          iconSize: 32,
          svgPath: svgPath,
          iconColor: iconColor,
          onTap: onTap,
        ),
        const Gap(Insets.small),
        Text(
          text,
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: textColor,
          ),
        )
      ],
    );
  }
}
