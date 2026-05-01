import 'package:flutter/material.dart';
import 'package:movies/core/cache/local_storage.dart';
import 'package:movies/features/ui/auth/register_screen/view/register_screen.dart';
import 'package:movies/features/ui/on_boarding_screen/view/on_boarding_screen.dart';

import 'core/cache/shared_prefs_utils.dart';
import 'core/utils/app_routes.dart';
import 'features/ui/auth/login_screen/view/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsUtils.init();
  final bool showOnboarding = LocalStorage.instance.onboarding;
  runApp(MyApp(showOnboarding: showOnboarding));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;

  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: showOnboarding
          ? AppRoutes.onboardingRouteName
          : AppRoutes.loginRouteName,
      routes: {
        AppRoutes.onboardingRouteName: (context) => OnBoardingScreen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
      },
    );
  }
}
