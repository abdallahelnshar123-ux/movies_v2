import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/utils/snack_bar_utils.dart';
import 'package:movies/features/ui/auth/cubit/auth_view_model.dart';
import 'package:movies/features/ui/home_screen/provider/home_screen_view_model.dart';
import 'package:movies/features/ui/home_screen/tabs/profile_tab/cubit/history_view_model.dart';
import 'package:movies/features/ui/home_screen/tabs/profile_tab/cubit/watchlist_view_model.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUser = context.read<AuthCubit>().currentUser;
      SnackBarUtils.showSnackBar(
        context: context,
        message: 'logged_in_as'.tr() + currentUser!.name,
      );
      context.read<WatchListCubit>().loadWatchList(currentUser.id);
      context.read<HistoryCubit>().loadHistory(currentUser.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: context.watch<HomeScreenViewModel>().selectedTab,
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: AppColors.darkGrayColor,
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        width: double.infinity,
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: AppColors.transparentColor,
            highlightColor: AppColors.transparentColor,
          ),
          child: BottomNavigationBar(
            fixedColor: AppColors.transparentColor,
            unselectedLabelStyle: TextStyle(fontSize: 0),
            selectedLabelStyle: TextStyle(fontSize: 0),
            backgroundColor: AppColors.transparentColor,
            onTap: (index) {
              context.read<HomeScreenViewModel>().changeIndex(index);
            },
            items: [
              builtBottomNavigationBarItem(
                iconName: AppAssets.bnbHomeIcon,
                index: 0,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.bnbSearchIcon,
                index: 1,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.bnbExploreIcon,
                index: 2,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.bnbProfileIcon,
                index: 3,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem builtBottomNavigationBarItem({
    required String iconName,
    required int index,
    required BuildContext context,
  }) {
    return BottomNavigationBarItem(
      label: '',
      icon: SvgPicture.asset(
        iconName,
        colorFilter: ColorFilter.mode(
          index == context.watch<HomeScreenViewModel>().selectedTabIndex
              ? AppColors.yellowColor
              : AppColors.whiteColor,
          BlendMode.srcIn,
        ),
        width: 24,
      ),
    );
  }
}
