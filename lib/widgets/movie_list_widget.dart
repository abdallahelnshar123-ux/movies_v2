import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';

import '../core/di/di.dart';
import '../core/utils/app_styles.dart';
import '../core/utils/screen_size.dart';
import '../features/ui/movie_details_screen/cubit/movie_details_view_model.dart';
import '../features/ui/movie_details_screen/view/movie_details_screen.dart';
import '../features/ui/movie_details_screen/view/widget/movie_suggestions_widget/cubit/movie_suggestions_view_model.dart';
import 'movie_item.dart';
import 'shimmer_widget.dart';

class MovieListWidget extends StatelessWidget {
  final ScrollController scrollController;

  final bool isPaginationLoading;

  final List<Movie> moviesList;

  const MovieListWidget({
    super.key,
    required this.scrollController,
    required this.moviesList,
    required this.isPaginationLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        right: context.width * 0.04,
        left: context.width * 0.04,
        bottom: context.height * 0.1,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: context.width * 0.04,
        mainAxisSpacing: context.width * 0.04,
        childAspectRatio: 0.7,
      ),
      itemCount: moviesList.length + (isPaginationLoading ? 2 : 0),
      itemBuilder: (context, index) {
        if (index >= moviesList.length) {
          return ShimmerWidget();
        }
        final movie = moviesList[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => getIt<MovieDetailsCubit>()),
                    BlocProvider(create: (_) => getIt<MovieSuggestionsCubit>()),
                  ],
                  child: MovieDetailsScreen(movieId: movie.id ?? -1),
                ),
              ),
            );
          },
          child: MovieItem(
            imageUrl: movie.mediumCoverImage ?? '',
            rating: movie.rating.toString(),
            ratingTextStyle: AppStyles.robotoRegular14White(context),
            startSize: 18,
            ratingPaddingHorizontal: 7,
            ratingPaddingVertical: 3,
            containerPadding: 10,
            containerBorderRadius: 12,
            ratingBorderRadius: 7,
          ),
        );
      },
    );
  }
}
