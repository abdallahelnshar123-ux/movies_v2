import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_assets.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/screen_size.dart';

class GenreMoviesWidget extends StatefulWidget {
  const GenreMoviesWidget({super.key});

  @override
  State<GenreMoviesWidget> createState() => _GenreMoviesWidgetState();
}

class _GenreMoviesWidgetState extends State<GenreMoviesWidget> {
  List<String> genresList = [
    'action',
    'adventure',
    'animation',
    'anime',
    'comedy',
    'crime',
    'documentary',
    'drama',
    'family',
    'fantasy',
    'horror',
    'music',
    'musical',
    'mystery',
    'reality TV',
    'romance',
    'sci-fi',
    'seasonal',
    'short',
    'sport',
    'thriller',
  ];
  var random = Random();
  late String randomGenre = genresList[random.nextInt(genresList.length)];

  @override
  void initState() {
    super.initState();
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
              Text(randomGenre, style: AppStyles.robotoRegular20White),
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
            separatorBuilder: (context, index) =>
                SizedBox(width: context.width * 0.03),
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.02),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
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
                      image: AssetImage(AppAssets.onBoardingImage2),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("7", style: AppStyles.robotoRegular10White),
                        SizedBox(width: context.width * .01),
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
}
