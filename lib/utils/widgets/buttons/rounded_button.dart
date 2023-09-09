import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.size,
    this.backgroundColor,
    this.iconColor,
    this.svgPath,
    this.icon,
    this.iconSize,
    this.hasBadge = false,
    this.count,
    required this.onTap,
  });
  final double? size;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? svgPath;
  final IconData? icon;
  final bool hasBadge;
  final int? count; // <- Here's the new count property
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(size ?? 56, size ?? 56),
      child: ClipOval(
        child: Material(
          color: backgroundColor ?? context.colorScheme.primary,
          child: InkWell(
            onTap: onTap,
            child: Center(
              child: svgPath != null
                  ? count !=
                          null // <- Use count to conditionally render Badge.count
                      ? Badge.count(
                          count: count!,
                          alignment: Alignment.topLeft,
                          backgroundColor: hasBadge
                              ? context.colorScheme.primary
                              : Colors.transparent,
                          child: SvgPicture.asset(
                            svgPath!,
                            // ignore: deprecated_member_use
                            color: iconColor,
                            height: iconSize,
                            width: iconSize,
                          ),
                        )
                      : Badge(
                          alignment: Alignment.topRight,
                          smallSize: 10,
                          backgroundColor: hasBadge
                              ? context.colorScheme.primary
                              : Colors.transparent,
                          child: SvgPicture.asset(
                            svgPath!,
                            // ignore: deprecated_member_use
                            color: iconColor,
                            height: iconSize,
                            width: iconSize,
                          ),
                        )
                  : Badge(
                      alignment: Alignment.topRight,
                      smallSize: 10,
                      backgroundColor: hasBadge
                          ? context.colorScheme.primary
                          : Colors.transparent,
                      child: Icon(
                        icon!,
                        color: iconColor ?? context.colorScheme.onPrimary,
                        size: iconSize ?? IconSize.small,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
