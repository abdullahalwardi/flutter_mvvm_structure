import 'package:app/common_lib.dart';
import 'package:flutter/widgets.dart';

class KeyValueText extends StatelessWidget {
  const KeyValueText({
    super.key,
    required this.text,
    required this.value,
    this.valueTextColor,
    this.isLineThrough = false,
  });

  final String text;
  final String value;
  final Color? valueTextColor;
  final bool isLineThrough;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        value,
        style: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: isLineThrough ? context.colorScheme.error : valueTextColor,
          decoration: isLineThrough ? TextDecoration.lineThrough : null,
        ),
      ),
      Text(
        text,
        style: context.textTheme.bodySmall,
      ),
    ]);
  }
}
