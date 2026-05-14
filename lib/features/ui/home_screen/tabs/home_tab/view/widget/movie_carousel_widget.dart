import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/provider/home_tab_provider.dart';

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
                    BlocProvider(
                      create: (_) => getIt<MovieDetailsCubit>(),
                    ),
                    BlocProvider(
                      create: (_) => getIt<MovieSuggestionsCubit>(),
                    ),
                  ],
                  child: MovieDetailsScreen(
                    movieId: moviesList[index].id ?? -1,
                  ),
                ),
              ),
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //
            //     builder: (context) =>
            //         MovieDetailsScreen(movieId: moviesList[index].id ?? -1),
            //   ),
            // );
          },
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: context.width * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      moviesList[index].largeCoverImage ?? '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(context.width * 0.03),

                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.blurColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    spacing: context.width * 0.01,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        moviesList[index].rating.toString(),
                        style: AppStyles.robotoRegular16White(context),
                      ),

                      Icon(Icons.star, color: Colors.amber, size: 22),
                    ],
                  ),
                ),
              ),
            ],
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
