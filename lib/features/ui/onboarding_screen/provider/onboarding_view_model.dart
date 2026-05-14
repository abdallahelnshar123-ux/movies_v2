import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  // final LocalStorage _localStorage;
  // OnboardingViewModel(this._localStorage);

  int currentIndex = 0;

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

  // void finishOnboarding(BuildContext context) async {
  //   await _localStorage.setOnboardingDone();
  //
  //   if (!context.mounted) return;
  //   Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
  // }
}
