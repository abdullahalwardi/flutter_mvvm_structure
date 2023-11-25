
import 'package:app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SliverPaddingToBoxAdapter extends StatelessWidget {
  const SliverPaddingToBoxAdapter({
    super.key,
    required this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
      sliver: SliverToBoxAdapter(
        child: child,
      ),
    );
  }
}