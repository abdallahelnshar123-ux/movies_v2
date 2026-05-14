import 'package:flutter/material.dart';


import '../../../../../domain/entities/response/movie/movie.dart';



class BookMarkWidget extends StatelessWidget {
  final Movie movie;

  const BookMarkWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {

    return Placeholder();
    // var userId = context.watch<AuthCubit>().currentUser?.id;
    //
    // if (userId == null) {
    //   return const SizedBox();
    // }
    //
    // return StreamBuilder<DocumentSnapshot<Movie>>(
    //   stream: FirebaseUtils.watchMovieInWatchList(uId: userId, movie: movie),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Icon(
    //         Icons.bookmark_border_rounded,
    //         size: 30,
    //         color: AppColors.whiteColor,
    //       );
    //     }
    //
    //     bool isSaved = snapshot.data?.exists ?? false;
    //
    //     return IconButton(
    //       selectedIcon: const Icon(Icons.bookmark_rounded),
    //       isSelected: isSaved,
    //
    //       iconSize: 30,
    //       color: AppColors.whiteColor,
    //       icon: const Icon(Icons.bookmark_border_rounded),
    //       onPressed: () async {
    //         if (isSaved) {
    //           await FirebaseUtils.deleteMovieFromWatchList(
    //             movie: movie,
    //             uId: userId,
    //           );
    //           debugPrint('delete');
    //         } else {
    //           await FirebaseUtils.addMovieToWatchList(
    //             movie: movie,
    //             uId: userId,
    //           );
    //           debugPrint('add');
    //         }
    //       },
    //     );
    //   },
    // );
  }
}
