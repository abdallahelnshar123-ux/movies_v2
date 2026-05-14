import 'package:flutter/material.dart';
import 'package:movies/widgets/shimmer_widget.dart';

import '../../../../../../../core/utils/screen_size.dart';





class MovieSuggestionsShimmerWidget extends StatelessWidget {


  const MovieSuggestionsShimmerWidget({super.key, });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: context.width *0.04,
        crossAxisSpacing: context.width *0.04,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ShimmerWidget()
        );
      },
      itemCount: 4,
    );
  }
}
