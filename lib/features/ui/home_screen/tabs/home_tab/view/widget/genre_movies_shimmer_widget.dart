import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../core/utils/screen_size.dart';

class GenreMoviesShimmerWidget extends StatelessWidget {
  const GenreMoviesShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.17,
      width: context.width,
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            SizedBox(width: context.width * 0.03),
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.02),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.black26,
            highlightColor: Colors.white24,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(16),
              ),
              width: context.width * 0.25,
              height: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
