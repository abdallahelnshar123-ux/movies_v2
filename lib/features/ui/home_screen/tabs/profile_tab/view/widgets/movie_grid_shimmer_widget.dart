import 'package:flutter/material.dart';
import 'package:movies/widgets/shimmer_widget.dart';

import '../../../../../../../core/utils/screen_size.dart';

class MovieGridShimmerWidget extends StatelessWidget {
  const MovieGridShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(
        right: context.width * 0.03,
        left: context.width * 0.03,
        top: context.width * 0.03,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.6,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return ShimmerWidget();
      },
    );
  }
}
