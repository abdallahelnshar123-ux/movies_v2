import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/utils/screen_size.dart';

class MovieCarouselShimmerWidget extends StatelessWidget {
  const MovieCarouselShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (context, index, realIndex) {
        return Shimmer.fromColors(
          baseColor: Colors.black26,
          highlightColor: Colors.white24,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            height: double.infinity,
          ),
        );
      },
      options: CarouselOptions(
        height: context.height * 0.45,
        enlargeCenterPage: true,
        viewportFraction: 0.7,
        onPageChanged: (index, reason) {},
      ),
    );
  }
}
