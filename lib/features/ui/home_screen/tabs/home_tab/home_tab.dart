import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/widget/genre_movies_widget.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/widget/movie_carousel_widget.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(AppAssets.onBoardingImage2),
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
                MovieCarouselWidget(),
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
