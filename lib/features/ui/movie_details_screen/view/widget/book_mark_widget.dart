import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../domain/entities/response/movie/movie.dart';
import '../../../auth/cubit/auth_view_model.dart';
import '../../../home_screen/tabs/profile_tab/cubit/watchlist_view_model.dart';

class BookMarkWidget extends StatelessWidget {
  final Movie movie;

  const BookMarkWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    var currentUser = context.watch<AuthCubit>().currentUser;
    var watchListCubit = context.watch<WatchListCubit>();
    var isBookMarked = watchListCubit.isMovieSaved(movie.id ?? 0);

    return IconButton(
      selectedIcon: const Icon(Icons.bookmark_rounded),
      isSelected: isBookMarked,
      iconSize: 30,
      color: AppColors.whiteColor,
      icon: const Icon(Icons.bookmark_border_rounded),
      onPressed: () async {
        if (currentUser == null) return;

        if (isBookMarked) {
          await watchListCubit.deleteMovie(movie: movie, uId: currentUser.id);
        } else {
          await watchListCubit.addMovie(movie: movie, uId: currentUser.id);
        }
      },
    );
  }
}
