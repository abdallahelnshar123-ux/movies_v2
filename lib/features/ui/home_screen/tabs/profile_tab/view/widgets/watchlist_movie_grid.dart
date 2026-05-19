import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/ui/home_screen/tabs/profile_tab/cubit/watchlist_view_model.dart';
import 'package:movies/widgets/movie_item.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';
import '../../../../../../../domain/entities/response/movie/movie.dart';
import '../../../../../auth/cubit/auth_view_model.dart';

class WatchlistMovieGrid extends StatelessWidget {
  final List<Movie> movies;

  const WatchlistMovieGrid({super.key, required this.movies});

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
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.darkGrayColor,
            borderRadius: BorderRadius.circular(context.width * 0.01),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: MovieItem(
                  imageUrl: movies[index].mediumCoverImage ?? '',
                  rating: movies[index].rating?.toString() ?? '',
                  ratingTextStyle: AppStyles.robotoRegular10White(context),
                  startSize: context.width * 0.03,
                  ratingPaddingHorizontal: context.width * 0.01,
                  ratingPaddingVertical: context.width * 0.01,
                  containerPadding: context.width * 0.01,
                  containerBorderRadius: context.width * 0.01,
                  ratingBorderRadius: context.width * 0.01,
                ),
              ),
              Expanded(
                flex: 2,
                child: IconButton(
                  iconSize: context.width * 0.07,
                  onPressed: () {
                    context.read<WatchListCubit>().deleteMovie(
                      movie: movies[index],
                      uId: context.read<AuthCubit>().currentUser?.id ?? '',
                    );
                  },
                  icon: Icon(Icons.delete, color: AppColors.redColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
