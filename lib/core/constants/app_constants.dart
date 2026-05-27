import 'package:flutter/material.dart';
import 'package:movies/domain/entities/on_boarding/on_boarding_item.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class AppConstants {
  static const List<String> genresList = [
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
  static const List<String> avatarList = [
    AppAssets.avatarImage1,
    AppAssets.avatarImage2,
    AppAssets.avatarImage3,
    AppAssets.avatarImage4,
    AppAssets.avatarImage5,
    AppAssets.avatarImage6,
    AppAssets.avatarImage7,
    AppAssets.avatarImage8,
    AppAssets.avatarImage9,
  ];
  static const String usersCollectionName = 'users';
  static const String watchListCollectionName = 'watch_list';
  static const String historyCollectionName = 'history';
  static const List<Color> gradientColors = [
    AppColors.blackGradientTop,
    AppColors.cyanGradiantColor,
    AppColors.orangeGradiantColor,
    AppColors.purpleGradiantColor,
    AppColors.redGradiantColor,
    AppColors.blackGradiantColor,
  ];

  static final List<OnBoardingItem> onBoardingPages = [
    OnBoardingItem(
      image: AppAssets.onBoardingImage1,
      subtitle: "onboarding_description1",
      title: "onboarding_title1",
      buttonNext: "explore_now",
    ),

    OnBoardingItem(
      image: AppAssets.onBoardingImage2,
      subtitle: "onboarding_description2",
      title: "onboarding_title2",
      buttonNext: "next",
    ),

    OnBoardingItem(
      image: AppAssets.onBoardingImage3,
      subtitle: "onboarding_description3",
      title: "onboarding_title3",
      buttonNext: "next",
      buttonBack: "back",
    ),

    OnBoardingItem(
      image: AppAssets.onBoardingImage4,
      subtitle: "onboarding_description4",
      title: "onboarding_title4",
      buttonNext: "next",
      buttonBack: "back",
    ),

    OnBoardingItem(
      image: AppAssets.onBoardingImage5,
      subtitle: "onboarding_description5",
      title: "onboarding_title5",
      buttonBack: "back",
      buttonNext: "next",
    ),

    OnBoardingItem(
      image: AppAssets.onBoardingImage6,
      subtitle: null,
      title: "onboarding_title6",
      buttonBack: "back",
      buttonNext: "finish",
    ),
  ];
}
