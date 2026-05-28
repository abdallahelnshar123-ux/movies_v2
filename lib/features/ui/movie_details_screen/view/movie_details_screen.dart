import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/utils/screen_size.dart';
import 'package:movies/features/ui/movie_details_screen/cubit/movie_details_view_model.dart';
import 'package:movies/features/ui/movie_details_screen/view/movie_details_ui.dart';
import 'package:movies/widgets/main_error_widget.dart';
import 'package:movies/widgets/main_loading_widget.dart';

import '../movie_details_state.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsCubit>().getMovieDetails(
      movieId: widget.movieId,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsSuccessState) {
          return MovieDetailsUI(movie: state.movie);
        }
        if (state is MovieDetailsErrorState) {
          return MainErrorWidget(
            errorMessage: state.message,
            onPressed: () {
              context.read<MovieDetailsCubit>().getMovieDetails(
                movieId: widget.movieId,
                context: context,
              );
            },
            widgetHeight: context.height,
          );
        }

        return MainLoadingWidget();
      },
    );
  }
}
