import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/utils/app_theme.dart';
import 'package:movies/features/ui/auth/register_screen/view/register_screen.dart';
import 'package:movies/features/ui/home_screen/home_screen.dart';
import 'package:movies/features/ui/home_screen/provider/home_screen_view_model.dart';
import 'package:movies/features/ui/home_screen/tabs/browse_tab/cubit/browse_view_model.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/cubit/home_tab__carousel_view_model.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/cubit/home_tab_genre_view_model.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/provider/home_tab_provider.dart';
import 'package:movies/features/ui/home_screen/tabs/search_tab/cubit/search_view_model.dart';
import 'package:movies/features/ui/onboarding_screen/provider/onboarding_view_model.dart';
import 'package:movies/features/ui/onboarding_screen/view/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/data_bases/cache/shared_prefs_utils.dart';
import 'features/ui/home_screen/tabs/profile_tab/cubit/watchlist_view_model.dart';
import 'firebase_options.dart';
import 'core/di/di.dart';

import 'core/utils/app_routes.dart';
import 'features/ui/auth/cubit/auth_view_model.dart';
import 'features/ui/auth/login_screen/view/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await SharedPrefsUtils.init();
  configureDependencies();
  final bool showOnboarding = false;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(
          create: (context) =>
              getIt<HomeTabCarouselCubit>()..getHomeTabMovies(),
        ),
        BlocProvider(create: (context) => getIt<HomeTabGenreCubit>()),
        BlocProvider(
          create: (context) => getIt<BrowseCubit>()..getBrowseMovies(),
        ),
        BlocProvider(create: (context) => getIt<SearchCubit>()),
        BlocProvider(
          create: (context) => getIt<WatchListCubit>()
            ..loadWatchList(context.read<AuthCubit>().currentUser?.id ?? ''),
        ),
        // BlocProvider(create: (context) => getIt<MovieDetailsCubit>()),
        // BlocProvider(create: (context) => getIt<MovieSuggestionsCubit>()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: MyApp(showOnboarding: showOnboarding),
      ),
    ),
  );
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
        AppRoutes.onboardingRouteName: (context) => ChangeNotifierProvider(
          create: (context) => OnboardingViewModel(),
          child: OnboardingScreen(),
        ),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.homeRouteName: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => HomeScreenViewModel()),
            ChangeNotifierProvider(create: (context) => HomeTabProvider()),
          ],
          child: HomeScreen(),
        ),
      },
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
