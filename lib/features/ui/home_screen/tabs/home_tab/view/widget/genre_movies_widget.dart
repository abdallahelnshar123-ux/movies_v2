import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/ui/home_screen/provider/home_screen_view_model.dart';
import 'package:movies/features/ui/home_screen/tabs/browse_tab/cubit/browse_view_model.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/cubit/home_tab_genre_view_model.dart';
import 'package:movies/features/ui/movie_details_screen/view/movie_details_screen.dart';
import 'package:movies/widgets/movie_item.dart';
import 'package:movies/widgets/shimmer_widget.dart';

import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';
import '../../../../../../../domain/entities/response/movie/movie.dart';
import '../../../../../movie_details_screen/cubit/movie_details_view_model.dart';
import '../../../../../movie_details_screen/view/widget/movie_suggestions_widget/cubit/movie_suggestions_view_model.dart';

class GenreMoviesWidget extends StatefulWidget {
  final List<Movie> moviesList;

  const GenreMoviesWidget({super.key, required this.moviesList});

  @override
  State<GenreMoviesWidget> createState() => _GenreMoviesWidgetState();
}

class _GenreMoviesWidgetState extends State<GenreMoviesWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(onScroll);
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.height * 0.015,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.watch<HomeTabGenreCubit>().randomGenre.tr(),
                style: AppStyles.robotoRegular20White(context),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      String selectedGenre = context
                          .read<HomeTabGenreCubit>()
                          .randomGenre;
                      context.read<HomeScreenViewModel>().changeIndex(2);

                      await context
                          .read<BrowseCubit>()
                          .getBrowseMoviesFromHomeTab(genre: selectedGenre);
                    },
                    child: Text(
                      "see_more".tr(),
                      style: AppStyles.robotoRegular16Yellow(context),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: AppColors.yellowColor,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(
          height: context.height * 0.17,
          child: ListView.separated(
            controller: scrollController,
            separatorBuilder: (context, index) =>
                SizedBox(width: context.width * 0.03),
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.02),
            scrollDirection: Axis.horizontal,
            itemCount:
                widget.moviesList.length +
                (context.watch<HomeTabGenreCubit>().isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == widget.moviesList.length) {
                return ShimmerWidget(width: context.width * 0.25);
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (_) => getIt<MovieDetailsCubit>(),
                          ),
                          BlocProvider(
                            create: (_) => getIt<MovieSuggestionsCubit>(),
                          ),
                        ],
                        child: MovieDetailsScreen(
                          movieId: widget.moviesList[index].id ?? -1,
                        ),
                      ),
                    ),
                  );
                },
                child: MovieItem(
                  imageUrl: widget.moviesList[index].largeCoverImage ?? '',
                  rating: widget.moviesList[index].rating.toString(),
                  ratingTextStyle: AppStyles.robotoRegular10White(context),
                  startSize: 12,
                  ratingPaddingHorizontal: 6,
                  ratingPaddingVertical: 3,
                  containerPadding: context.width * 0.015,
                  containerWidth: context.width * 0.25,
                  ratingBorderRadius: 7,
                  containerBorderRadius: 10,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void onScroll() {
    if (context.read<HomeTabGenreCubit>().isLoading) {
      return;
    }

    final maxScroll = scrollController.position.maxScrollExtent;

    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= maxScroll * 0.8) {
      context.read<HomeTabGenreCubit>().getHomeTabGenreMovies(
        isPagination: true,
      );
    }
  }
}
