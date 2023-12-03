import 'dart:async';

import 'package:app/common_lib.dart';
import 'package:app/utils/widgets/carousel/carousel_banner.dart';
import 'package:app/utils/widgets/carousel/dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Carousel extends StatefulWidget {
  final List<String> ads;
  const Carousel({super.key, required this.ads});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _selectedIndex = 0;
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(Time.extraLarge * 4, (Timer timer) {
      if (_selectedIndex < widget.ads.length - 1) {
        _selectedIndex++;
      } else {
        _selectedIndex = 0;
      }

      _pageController.animateToPage(
        _selectedIndex,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Insets.large),
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.ads.length,
              onPageChanged: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              itemBuilder: (context, index) => CarouselBanner(
                image: widget.ads[index],
                press: () {
                  launchUrl(Uri.parse(widget.ads[index]));
                },
              ),
            ),
          ),
        ),
        const Gap(Insets.small),
        FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(Insets.extraSmall),
            child: SizedBox(
              height: 16,
              child: Row(
                children: List.generate(
                  widget.ads.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: Insets.small),
                      child: DotIndicator(
                        isActive: index == _selectedIndex,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
