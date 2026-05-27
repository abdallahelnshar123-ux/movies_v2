import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/utils/screen_size.dart';
import 'package:movies/features/ui/onboarding_screen/provider/onboarding_view_model.dart';
import 'package:movies/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
              key: ValueKey(AppConstants.onBoardingPages[currentIndex].image),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    AppConstants.onBoardingPages[currentIndex].image,
                  ),
                ),
              ),
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.transparentColor,
                    AppConstants.gradientColors[currentIndex].withAlpha(70),
                    AppConstants.gradientColors[currentIndex],
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
    final OnboardingViewModel provider = context.watch<OnboardingViewModel>();

    return BottomSheet(
      backgroundColor: provider.currentIndex == 0
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
                AppConstants.onBoardingPages[provider.currentIndex].title.tr(),
                textAlign: TextAlign.center,
                style: AppStyles.interBold24white,
              ),
              Visibility(
                visible:
                    AppConstants.onBoardingPages[provider.currentIndex].subtitle
                        ?.tr() !=
                    null,
                child: Text(
                  AppConstants.onBoardingPages[provider.currentIndex].subtitle
                          ?.tr() ??
                      '',
                  textAlign: TextAlign.center,
                  style: AppStyles.interRegular16White,
                ),
              ),
              CustomElevatedButton(
                onPressed: provider.currentIndex != 5
                    ? provider.nextPage
                    : () {
                        provider.finishOnboarding(context);
                      },
                backgroundColor: AppColors.yellowColor,
                child: Text(
                  AppConstants.onBoardingPages[provider.currentIndex].buttonNext
                          ?.tr() ??
                      '',
                  style: AppStyles.interSBold20Black,
                ),
              ),

              Visibility(
                visible:
                    provider.currentIndex != 0 && provider.currentIndex != 1,
                child: CustomElevatedButton(
                  onPressed: provider.previousPage,
                  backgroundColor: AppColors.blackColor,
                  borderSideColor: AppColors.yellowColor,
                  child: Text(
                    AppConstants
                            .onBoardingPages[provider.currentIndex]
                            .buttonBack
                            ?.tr() ??
                        '',
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
