
import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';

class SliverPaddingToBoxAdapter extends StatelessWidget {
  const SliverPaddingToBoxAdapter({
    super.key,
    this.child = const SizedBox.shrink(),
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: Insets.medium,
      ),
      sliver: SliverToBoxAdapter(
        child: child,
      ),
    );
  }
}