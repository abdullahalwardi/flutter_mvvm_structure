import 'package:app/common_lib.dart';
import 'package:app/utils/widgets/break_line.dart';
import 'package:flutter/material.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    super.key,
    required this.title,
    this.onClose,
    this.trailing,
  });

  final String title;
  final VoidCallback? onClose;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(Insets.medium),
        const BreakLine(),
        const Gap(Insets.medium),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onClose ?? () => GoRouter.of(context).pop(),
                icon: Icon(
                  Icons.close,
                  color: cs.error,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: cs.primary,
                ),
              ),
              trailing ??
                  const SizedBox(
                    width: 48,
                    height: 48,
                  ),
            ],
          ),
        ),
        const Gap(Insets.medium),
      ],
    );
  }
}
