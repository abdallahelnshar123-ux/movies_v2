import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/app_routes.dart';
import 'package:movies/domain/use_cases/set_onboarding_done_use_case.dart';

@injectable
class OnboardingViewModel extends ChangeNotifier {
  final SetOnboardingDoneUseCase _setOnboardingDoneUseCase;

  int currentIndex = 0;

  OnboardingViewModel(this._setOnboardingDoneUseCase);

  void changeIndex(int index) {
    if (currentIndex != index) {
      currentIndex = index;
    }
    notifyListeners();
  }

  void nextPage() {
    if (currentIndex < 5) {
      currentIndex++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      currentIndex--;
      notifyListeners();
    }
  }

  void finishOnboarding(BuildContext context) {
    _setOnboardingDoneUseCase.setOnboardingDone();

    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
  }
}
