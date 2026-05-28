import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/widgets/shimmer_widget.dart';

import '../../../../../../../core/utils/screen_size.dart';

class MovieCarouselShimmerWidget extends StatelessWidget {
  const MovieCarouselShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (context, index, realIndex) {
        return ShimmerWidget();
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
