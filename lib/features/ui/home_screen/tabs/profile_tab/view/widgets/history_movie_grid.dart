import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/widgets/movie_item.dart';

import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';
import '../../../../../../../domain/entities/response/movie/movie.dart';
import '../../../../../movie_details_screen/cubit/movie_details_view_model.dart';
import '../../../../../movie_details_screen/view/movie_details_screen.dart';
import '../../../../../movie_details_screen/view/widget/movie_suggestions_widget/cubit/movie_suggestions_view_model.dart';

class HistoryMovieGrid extends StatelessWidget {
  final List<Movie> moviesList;

  const HistoryMovieGrid({super.key, required this.moviesList});

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
      itemCount: moviesList.length,
      itemBuilder: (context, index) {
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
                  child: MovieDetailsScreen(
                    movieId: moviesList[index].id ?? -1,
                  ),
                ),
              ),
            );
          },
          child: MovieItem(
            imageUrl: moviesList[index].mediumCoverImage ?? '',
            rating: moviesList[index].rating?.toString() ?? '',
            ratingTextStyle: AppStyles.robotoRegular10White(context),
            startSize: context.width * 0.03,
            ratingPaddingHorizontal: context.width * 0.01,
            ratingPaddingVertical: context.width * 0.01,
            containerPadding: context.width * 0.01,
            containerBorderRadius: context.width * 0.01,
            ratingBorderRadius: context.width * 0.01,
          ),
        );
      },
    );
  }
}
