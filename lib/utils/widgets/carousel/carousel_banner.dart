import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CarouselBanner extends StatelessWidget {
  const CarouselBanner({
    super.key,
    this.image,
    required this.press,
  });
  final String? image;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: image!,
      press: press,
    );
  }
}

class BannerM extends StatelessWidget {
  const BannerM({
    super.key,
    required this.image,
    required this.press,
    this.children = const [],
  });

  final String image;
  final VoidCallback press;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(imageUrl: image, fit: BoxFit.cover),
          Container(color: Colors.black12),
          ...children,
        ],
      ),
    );
  }
}
