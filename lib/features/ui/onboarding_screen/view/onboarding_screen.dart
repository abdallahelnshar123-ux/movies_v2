import 'package:flutter/material.dart';
import 'package:movies/core/utils/screen_size.dart';
import 'package:movies/features/ui/onboarding_screen/provider/onboarding_view_model.dart';
import 'package:movies/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final List<Color> gradientColors = [
    AppColors.blackGradientTop,
    AppColors.cyanGradiantColor,
    AppColors.orangeGradiantColor,
    AppColors.purpleGradiantColor,
    AppColors.redGradiantColor,
    AppColors.blackGradiantColor,
  ];

  final List<Map<String, dynamic>> pages = [
    {
      "image": AppAssets.onBoardingImage1,
      "title": "Find Your Next Favorite Movie Here",
      "subtitle":
          "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      "button_next": 'Explore Now',
      "button_back": null,
    },
    {
      "image": AppAssets.onBoardingImage2,
      "title": "Discover Movies",
      "subtitle":
          "Explore a vast collection of movies in all qualities and genres."
          " Find your next favorite film with ease.",
      "button_next": "Next",
      "button_back": null,
    },
    {
      "image": AppAssets.onBoardingImage3,
      "title": "Explore All Genres",
      "subtitle":
          "Discover movies from every genre, in all available qualities."
          " Find something new and exciting to watch every day.",
      "button_next": "Next",
      "button_back": "Back",
    },
    {
      "image": AppAssets.onBoardingImage4,
      "title": "Create Watchlist",
      "subtitle":
          "Save movies to your watchlist to keep track of what you want to watch next."
          " Enjoy films in various qualities and genres.",
      "button_next": "Next",
      "button_back": "Back",
    },
    {
      "image": AppAssets.onBoardingImage5,
      "title": "Rate, Review, and Learn",
      "subtitle":
          "Share your thoughts on the movies you've watched. Dive deep into film "
          "details and help others discover great movies with your reviews.",
      "button_next": "Next",
      "button_back": "Back",
    },
    {
      "image": AppAssets.onBoardingImage6,
      "title": "Start Watching Now",
      "subtitle": null,
      "button_next": "Finish",
      "button_back": "Back",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int currentIndex = context.watch<OnboardingViewModel>().currentIndex;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Container(
              key: ValueKey(pages[currentIndex]['image']),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(pages[currentIndex]['image']),
                ),
              ),
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.transparentColor,
                    gradientColors[currentIndex].withAlpha(70),
                    gradientColors[currentIndex],
                  ],
                  stops: [0, 0.2, 0.9],
                ),
              ),
            ),
          ),
          builtBottomSheet(context),
        ],
      ),
    );
  }

  Widget builtBottomSheet(BuildContext context) {
    final OnboardingViewModel vm = context.watch<OnboardingViewModel>();

    return BottomSheet(
      backgroundColor: vm.currentIndex == 0
          ? AppColors.transparentColor
          : AppColors.blackColor,
      showDragHandle: false,
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: EdgeInsetsGeometry.fromLTRB(
            context.width * 0.04,
            context.height * 0.04,
            context.width * 0.04,
            context.width * 0.02,
          ),
          child: Column(
            spacing: context.width * 0.03,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                pages[vm.currentIndex]["title"],
                textAlign: TextAlign.center,
                style: AppStyles.interBold24white,
              ),
              Visibility(
                visible: pages[vm.currentIndex]["subtitle"] != null,
                child: Text(
                  pages[vm.currentIndex]["subtitle"] ?? '',
                  textAlign: TextAlign.center,
                  style: AppStyles.interRegular16White,
                ),
              ),
              CustomElevatedButton(
                onPressed: vm.currentIndex != 5
                    ? vm.nextPage
                    : () {
                  // todo : finish on boarding
                        // vm.finishOnboarding(context);
                      },
                backgroundColor: AppColors.yellowColor,
                child: Text(
                  pages[vm.currentIndex]["button_next"] ?? '',
                  style: AppStyles.interSBold20Black,
                ),
              ),

              Visibility(
                visible: vm.currentIndex != 0 && vm.currentIndex != 1,
                child: CustomElevatedButton(
                  onPressed: vm.previousPage,
                  backgroundColor: AppColors.blackColor,
                  borderSideColor: AppColors.yellowColor,
                  child: Text(
                    pages[vm.currentIndex]["button_back"] ?? '',
                    style: AppStyles.interSBold20yellow,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
