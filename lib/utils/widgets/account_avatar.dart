import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import 'package:app/common_lib.dart';

class AccountAvatar extends StatelessWidget {
  const AccountAvatar({
    super.key,
    required this.imageUrl,
    this.size = 56,
    this.isVerified = false,
    this.verifiedSize = 20
  });

  final String imageUrl;
  final double size, verifiedSize;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Badge(
      label:
          // isVerified ? SvgPicture.asset(Assets.assetsSvgCheckmarkBadge) :
           null,
      smallSize: verifiedSize,
      largeSize: verifiedSize,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      alignment: Alignment.topRight,
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: imageUrl,
        imageBuilder:(context, imageProvider)=> Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isVerified
                  ? context.colorScheme.primary
                  : const Color(0xFF000000),
              width: isVerified ? 1 : 0.15,
            ),
            image: DecorationImage(
              image: imageProvider,
            ),
          ),
        ),
        placeholder: (context, url) =>  SkeletonAvatar(
          style: SkeletonAvatarStyle(shape: BoxShape.circle, height: size, width: size),
        ),
      ),
    );
  }
}
