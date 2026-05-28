import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/provider/home_tab_provider.dart';
import 'package:movies/widgets/movie_item.dart';

import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';
import '../../../../../movie_details_screen/cubit/movie_details_view_model.dart';
import '../../../../../movie_details_screen/view/movie_details_screen.dart';
import '../../../../../movie_details_screen/view/widget/movie_suggestions_widget/cubit/movie_suggestions_view_model.dart';

class MovieCarouselWidget extends StatelessWidget {
  final List<Movie> moviesList;

  const MovieCarouselWidget({super.key, required this.moviesList});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: moviesList.length,
      itemBuilder: (context, index, realIndex) {
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
            imageUrl: moviesList[index].largeCoverImage ?? '',
            rating: moviesList[index].rating.toString(),
            ratingTextStyle: AppStyles.robotoRegular16White(context),
            startSize: 20,
            ratingPaddingHorizontal: 8,
            ratingPaddingVertical: 4,
            containerPadding: context.width * 0.03,
            containerBorderRadius: 15,
            ratingBorderRadius: 10,
          ),
        );
      },
      options: CarouselOptions(
        height: context.height * 0.45,
        enlargeCenterPage: true,
        viewportFraction: 0.7,
        onPageChanged: (index, reason) {
          context.read<HomeTabProvider>().changeCarouselIndex(index);
        },
      ),
    );
  }
}
