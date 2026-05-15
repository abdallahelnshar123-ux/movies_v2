import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/ui/home_screen/tabs/browse_tab/browse_state.dart';

import '../../../../../../../core/di/di.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';
import '../../../../../../../widgets/movie_item.dart';
import '../../../../../../../widgets/shimmer_widget.dart';
import '../../../../../movie_details_screen/cubit/movie_details_view_model.dart';
import '../../../../../movie_details_screen/view/movie_details_screen.dart';
import '../../../../../movie_details_screen/view/widget/movie_suggestions_widget/cubit/movie_suggestions_view_model.dart';

class MovieListWidget extends StatelessWidget {
  final ScrollController scrollController;
  final BrowseSuccessState state;

  const MovieListWidget({
    super.key,
    required this.scrollController,
    required this.state,
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
      itemCount: state.moviesList.length + (state.isPaginationLoading ? 2 : 0),
      itemBuilder: (context, index) {
        if (index >= state.moviesList.length) {
          return ShimmerWidget();
        }
        final movie = state.moviesList[index];

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
