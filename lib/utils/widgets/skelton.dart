import 'package:app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';


class CustomSkeleton extends StatelessWidget {
  const CustomSkeleton({super.key, this.height, this.width, this.layer = 1});

  final double? height, width;
  final int layer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(Insets.medium / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04 * layer),
          borderRadius:
              const BorderRadius.all(Radius.circular(BorderSize.small))),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, this.size = 24});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      // padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}