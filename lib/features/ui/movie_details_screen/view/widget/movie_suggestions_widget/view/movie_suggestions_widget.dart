import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/ui/movie_details_screen/cubit/movie_details_view_model.dart';
import 'package:movies/features/ui/movie_details_screen/view/movie_details_screen.dart';

import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';
import '../../../../../../../domain/entities/response/movie/movie.dart';
import '../cubit/movie_suggestions_view_model.dart';

class MovieSuggestionsWidget extends StatelessWidget {
  final List<Movie> moviesList;

  const MovieSuggestionsWidget({super.key, required this.moviesList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: context.width * 0.04,
        crossAxisSpacing: context.width * 0.04,
        childAspectRatio: 0.7,
      ),
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
          child: Container(
            padding: EdgeInsets.all(context.width * 0.015),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  moviesList[index].largeCoverImage ??
                      moviesList[index].mediumCoverImage ??
                      '',
                ),
                fit: BoxFit.cover,
              ),
            ),
            width: 20,
            height: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.blurColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                spacing: context.width * .01,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    moviesList[index].rating.toString(),
                    style: AppStyles.robotoRegular10White(context),
                  ),
                  Icon(Icons.star, color: Colors.amber, size: 14),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: moviesList.length,
    );
  }
}
