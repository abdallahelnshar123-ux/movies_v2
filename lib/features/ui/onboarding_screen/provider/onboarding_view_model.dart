import 'package:flutter/material.dart';
import 'package:movies/core/cache/local_storage.dart';
import 'package:movies/core/utils/app_routes.dart';

class OnboardingViewModel extends ChangeNotifier {

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

  void finishOnboarding(BuildContext context) async {
    await LocalStorage.instance.setOnboardingDone();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
  }
}
