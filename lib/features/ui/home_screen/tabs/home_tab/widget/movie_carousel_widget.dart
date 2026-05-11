import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/screen_size.dart';

class MovieCarouselWidget extends StatelessWidget {
  const MovieCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      // todo : count
      itemCount: 10,
      itemBuilder: (context, index, realIndex) {
        return GestureDetector(
          onTap: () {
            // todo : navigate to movie
            // Navigator.pushNamed(
            //   context,
            //   AppRoutes.movieDetailsScreen,
            //   arguments: moviesList[index].id,
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
                    image: AssetImage(AppAssets.onBoardingImage2),
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
                        // todo : rating
                        '7',
                        style: AppStyles.robotoRegular16White,
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
          // todo : change index
        },
      ),
    );
  }
}
