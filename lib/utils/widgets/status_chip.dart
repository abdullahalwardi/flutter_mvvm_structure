import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.state,
  });

  final dynamic state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.small,
        vertical: Insets.extraSmall,
      ),
      decoration: BoxDecoration(
        color: state?.getColor(context),
        borderRadius: BorderSize.extraSmallRadius,
      ),
      child: Text(
        state?.getName(context) ?? "",
        style: context.textTheme.bodyMedium?.copyWith(
          color: state?.getTextColor(context),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
