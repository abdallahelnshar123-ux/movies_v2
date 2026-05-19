import 'package:flutter/material.dart';
import 'package:movies/widgets/movie_item.dart';

import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';
import '../../../../../../../domain/entities/response/movie/movie.dart';

class HistoryMovieGrid extends StatelessWidget {
  final List<Movie> movies;

  const HistoryMovieGrid({super.key, required this.movies});

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
        childAspectRatio: 0.65,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieItem(
          imageUrl: movies[index].mediumCoverImage ?? '',
          rating: movies[index].rating?.toString() ?? '',
          ratingTextStyle: AppStyles.robotoRegular10White(context),
          startSize: context.width * 0.03,
          ratingPaddingHorizontal: context.width * 0.01,
          ratingPaddingVertical: context.width * 0.01,
          containerPadding: context.width * 0.01,
          containerBorderRadius: context.width * 0.01,
          ratingBorderRadius: context.width * 0.01,
        );
      },
    );
  }
}
