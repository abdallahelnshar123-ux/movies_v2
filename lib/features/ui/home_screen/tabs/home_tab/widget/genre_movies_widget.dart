import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/cubit/home_tab_genre_view_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/screen_size.dart';
import '../../../../../../domain/entities/response/movie/movie.dart';

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
                style: AppStyles.robotoRegular20White,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See More",
                      style: AppStyles.robotoRegular16Yellow,
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
                return Shimmer.fromColors(
                  baseColor: Colors.black26,
                  highlightColor: Colors.white24,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: context.width * 0.25,
                    height: double.infinity,
                  ),
                );
              }
              return GestureDetector(
                onTap: () {
                  // todo : navigate to movie
                  // Navigator.pushNamed(
                  //   context,
                  //   AppRoutes.movieDetailsScreen,
                  //   arguments: moviesList[index].id,
                  // );
                },
                child: Container(
                  padding: EdgeInsets.all(context.width * 0.015),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        widget.moviesList[index].largeCoverImage ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: context.width * 0.25,
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
                          widget.moviesList[index].rating.toString(),
                          style: AppStyles.robotoRegular10White,
                        ),
                        Icon(Icons.star, color: Colors.amber, size: 14),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void onScroll() {
    if (context.read<HomeTabGenreCubit>().isLoading) return;

    final maxScroll = scrollController.position.maxScrollExtent;

    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= maxScroll * 0.8) {
      context.read<HomeTabGenreCubit>().getHomeTabGenreMovies(
        isPagination: true,
      );
    }
  }
}
