import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';
import 'package:movies/features/ui/movie_details_screen/view/widget/movie_suggestions_widget/cubit/movie_suggestions_view_model.dart';
import 'package:movies/features/ui/movie_details_screen/view/widget/movie_suggestions_widget/movie_suggestions_state.dart';
import 'package:movies/features/ui/movie_details_screen/view/widget/movie_suggestions_widget/view/movie_suggestions_shimmer_widget.dart';
import 'package:movies/features/ui/movie_details_screen/view/widget/movie_suggestions_widget/view/movie_suggestions_widget.dart';
import 'package:movies/features/ui/movie_details_screen/view/widget/rating_widget.dart';

import 'package:movies/features/ui/movie_details_screen/view/widget/cast_widget.dart';
import 'package:movies/features/ui/movie_details_screen/view/widget/genres_widget.dart';
import 'package:movies/features/ui/movie_details_screen/view/widget/screen_shots_widget.dart';
import 'package:movies/features/ui/movie_details_screen/view/widget/summary_widget.dart';
import 'package:movies/features/ui/movie_details_screen/view/widget/title_widget.dart';

import 'package:movies/widgets/custom_elevated_button.dart';
import 'package:movies/widgets/main_error_widget.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_size.dart';

class MovieDetailsUI extends StatefulWidget {
  final Movie movie;

  const MovieDetailsUI({super.key, required this.movie});

  @override
  State<MovieDetailsUI> createState() => _MovieDetailsUIState();
}

class _MovieDetailsUIState extends State<MovieDetailsUI> {

  @override
  void initState() {
    super.initState();
    context.read<MovieSuggestionsCubit>().getMovieSuggestions(
      movieId: widget.movie.id ?? -1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              CachedNetworkImage(
                imageUrl: widget.movie.largeCoverImage ?? '',

                fit: BoxFit.fitWidth,
                errorWidget: (context, url, error) =>
                    Icon(Icons.error_outline, color: AppColors.yellowColor),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: context.width * 0.02),
                alignment: Alignment.topCenter,
                height: context.height * 0.8,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      AppColors.blackColor.withAlpha(230),
                      AppColors.transparentColor,
                    ],
                    stops: [0.15, 0.3, 1],
                  ),
                ),
                child: Column(
                  spacing: 15,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: context.height * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            iconSize: 30,
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          // BookMarkWidget(movie: widget.movie),
                        ],
                      ),
                    ),
                    SizedBox(height: context.height * 0.15),
                    Image.asset(AppAssets.playMovieImage),
                    Spacer(),
                    Text(
                      widget.movie.titleEnglish ??
                          widget.movie.title ??
                          'no title',
                      style: AppStyles.robotoBold24White(context),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.movie.year?.toString() ?? '',
                      style: AppStyles.robotoBold20LightGray(context),
                      textAlign: TextAlign.center,
                    ),

                    ///todo: Watch Button
                    CustomElevatedButton(
                      onPressed: () {
                        // final String? userId =
                        //     context.read<AuthCubit>().currentUser?.id;
                        // if (userId != null) {
                        //   FirebaseUtils.addMovieToHistory(
                        //     movie: widget.movie,
                        //     uId: userId,
                        //   );
                        // }
                      },
                      backgroundColor: AppColors.redColor,
                      child: Text(
                        "watch".tr(),
                        style: AppStyles.robotoBold20White(context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      spacing: 11,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingWidget(
                          text: widget.movie.likeCount?.toString() ?? '0',
                          icon: AppAssets.heartIcon,
                        ),
                        RatingWidget(
                          text: widget.movie.runtime?.toString() ?? '0',
                          icon: AppAssets.clockIcon,
                        ),
                        RatingWidget(
                          text: widget.movie.rating?.toString() ?? '0',
                          icon: AppAssets.starIcon,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(
              context.width * 0.02,
              0,
              context.width * 0.02,
              context.width * 0.02,
            ),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TitleWidget(text: "screen_shots".tr()),
                ScreenShotsWidget(
                  screenShotsList: widget.movie.screenshots ?? [],
                ),
                TitleWidget(text: "similar".tr()),
                // todo :  similar
                BlocBuilder<MovieSuggestionsCubit, MovieSuggestionsState>(
                  builder: (context, state) {
                    if (state is MovieSuggestionsSuccessState) {
                      return MovieSuggestionsWidget(
                        moviesList: state.movieList,
                      );
                    }
                    if (state is MovieSuggestionsErrorState) {
                      return MainErrorWidget(
                        errorMessage: state.message,
                        onPressed: () {
                          context
                              .read<MovieSuggestionsCubit>()
                              .getMovieSuggestions(
                                movieId: widget.movie.id ?? -1,
                              );
                        },
                        widgetHeight: context.width,
                      );
                    }
                    return MovieSuggestionsShimmerWidget();
                  },
                ),

                TitleWidget(text: "Summary"),
                SummaryWidget(
                  summary:
                      widget.movie.descriptionFull ?? 'no_summary_found'.tr(),
                ),
                TitleWidget(text: 'cast'.tr()),

                // todo : cast Widget
                CastWidget(castList: widget.movie.cast ?? []),
                TitleWidget(text: 'Genres'),
                GenresWidget(genresList: widget.movie.genres ?? []),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
