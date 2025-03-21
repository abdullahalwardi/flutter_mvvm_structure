import 'package:app/common_lib.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AccountAvatar extends StatelessWidget {
  const AccountAvatar({
    super.key,
    required this.imageUrl,
    this.size = 56,
    this.isVerified = false,
    this.verifiedSize = 20,
    this.isEditiable = false,
    this.onTap,
  });

  final String? imageUrl;
  final double size, verifiedSize;
  final bool isVerified;
  final bool isEditiable;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderSize.extraLargeRadius,
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Badge(
            label:
                // isVerified ? SvgPicture.asset(Assets.assetsSvgCheckmarkBadge) :
                null,
            smallSize: verifiedSize,
            largeSize: verifiedSize,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            alignment: Alignment.topRight,
            child: imageUrl == null
                ? Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isVerified
                            ? context.colorScheme.primary
                            : context.colorScheme.outline,
                        width: isVerified ? 1 : 0.25,
                      ),
                    ),
                    padding: Insets.extraSmallAll,
                    child: SvgPicture.asset(
                            Assets.assetsSvgCameraPlus,
                            fit: BoxFit.contain,
                          ),
                  )
                : CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imageUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isVerified
                              ? context.colorScheme.primary
                              : context.colorScheme.outline,
                          width: isVerified ? 1 : 0.25,
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerHighest,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isVerified
                              ? context.colorScheme.primary
                              : context.colorScheme.outline,
                          width: isVerified ? 1 : 0.25,
                        ),
                      ),
                      padding: Insets.smallAll,
                      child: SvgPicture.asset(
                        Assets.assetsSvgCameraPlus,
                        fit: BoxFit.contain,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerHighest,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isVerified
                              ? context.colorScheme.primary
                              : context.colorScheme.outline,
                          width: isVerified ? 1 : 0.25,
                        ),
                      ),
                      padding: Insets.smallAll,
                      child: SvgPicture.asset(
                        Assets.assetsSvgCameraPlus,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          if (isEditiable)
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                border: Border.all(
                  color: context.colorScheme.primary,
                  width: 1,
                ),
                shape: BoxShape.circle,
              ),
              padding: Insets.extraSmallAll,
              child: SvgPicture.asset(
                Assets.assetsSvgCameraPlus,
                color: context.colorScheme.primary,
              ),
            ),
        ],
      ),
    );
  }
}
