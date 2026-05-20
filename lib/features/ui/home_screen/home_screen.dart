import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/features/ui/home_screen/provider/home_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              // todo :  change tab
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
