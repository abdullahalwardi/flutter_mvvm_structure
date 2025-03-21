
import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';

class BreakLine extends StatelessWidget {
  const BreakLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 3,
          width: 120,
          decoration: BoxDecoration(
            color: context.colorScheme.outline,
            borderRadius: BorderSize.mediumRadius,
          ),
        ),
      );
  }
}