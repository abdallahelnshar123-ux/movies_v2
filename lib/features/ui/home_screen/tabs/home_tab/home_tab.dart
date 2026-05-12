import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/cubit/home_tab_view_model.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/home_tab_state.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/provider/home_tab_provider.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/widget/genre_movies_widget.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/widget/movie_carousel_shimmer_widget.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/widget/movie_carousel_widget.dart';
import 'package:movies/widgets/main_error_widget.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/screen_size.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // context.read<HomeTabCubit>().getHomeTabMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          BlocBuilder<HomeTabCubit, HomeTabState>(
            builder: (BuildContext context, HomeTabState state) {
              if (state is HomeMoviesSuccessState) {
                return CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl:
                      context
                          .watch<HomeTabCubit>()
                          .moviesList[context
                              .watch<HomeTabProvider>()
                              .carouselIndex]
                          .largeCoverImage ??
                      '',
                );
              }
              // if (state is HomeMoviesErrorState ||
              //     state is HomeMoviesLoadingState) {
              //   return MainErrorWidget(
              //     errorMessage: state.message,
              //     onPressed: () {
              //       context.read<HomeTabCubit>().getHomeTabMovies();
              //     },
              //     widgetHeight: context.height * 0.45,
              //   );
              // }
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black26,
              );
            },
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(color: AppColors.blurColor),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: context.height * 0.05),
                Image.asset(AppAssets.availableNowImage),
                SizedBox(height: context.height * 0.03),
                BlocBuilder<HomeTabCubit, HomeTabState>(
                  builder: (BuildContext context, HomeTabState state) {
                    if (state is HomeMoviesSuccessState) {
                      return MovieCarouselWidget(
                        moviesList: context.read<HomeTabCubit>().moviesList,
                      );
                    }
                    if (state is HomeMoviesErrorState) {
                      return MainErrorWidget(
                        errorMessage: state.message,
                        onPressed: () {
                          context.read<HomeTabCubit>().getHomeTabMovies();
                        },
                        widgetHeight: context.height * 0.45,
                      );
                    }
                    return MovieCarouselShimmerWidget();
                  },
                ),
                SizedBox(height: context.height * 0.02),
                Image.asset(AppAssets.watchNowImage),
                SizedBox(height: context.height * 0.02),
                GenreMoviesWidget(),
                SizedBox(height: context.height * 0.1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
