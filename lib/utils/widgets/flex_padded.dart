import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ColumnPadded extends Column {
  ColumnPadded({
    super.key,
    double gap = 8,
    required List<Widget> children,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
  }) : super(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1) Gap(gap),
            ]
          ],
        );
}

class RowPadded extends Row {
  RowPadded({
    super.key,
    double gap = 8,
    required List<Widget> children,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
  }) : super(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1) Gap(gap),
            ]
          ],
        );
}

class FlexPadded extends Flex {
  FlexPadded({
    super.key,
    double gap = 8,
    required super.direction,
    required List<Widget> children,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
  }) : super(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1) Gap(gap),
            ]
          ],
        );
}
