import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/features/ui/home_screen/tabs/profile_tab/cubit/history_view_model.dart';
import 'package:movies/features/ui/home_screen/tabs/profile_tab/history_state.dart';

import '../../../../../../../core/utils/app_assets.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';
import '../../cubit/watchlist_view_model.dart';
import '../../watchlist_state.dart';
import 'history_movie_grid.dart';
import 'movie_grid_shimmer_widget.dart';
import 'watchlist_movie_grid.dart';

class SectionSwitcher extends StatelessWidget {
  final ValueNotifier<int> tabIndex = ValueNotifier(0);

  SectionSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          /// container for background ===================================
          Container(
            decoration: BoxDecoration(color: AppColors.darkGrayColor),
            child: TabBar(
              overlayColor: WidgetStatePropertyAll(AppColors.darkGrayColor),
              dividerColor: AppColors.transparentColor,
              indicatorWeight: 3,
              labelColor: AppColors.whiteColor,
              unselectedLabelColor: AppColors.whiteColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppColors.yellowColor,
              onTap: (index) => tabIndex.value = index,
              tabs: [
                ValueListenableBuilder(
                  valueListenable: tabIndex,
                  builder: (context, value, child) {
                    return builtTab(
                      iconWidget: SvgPicture.asset(
                        AppAssets.wishlistIcon,
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                      label: 'watch_list'.tr(),
                      isSelected: value == 0,
                      context: context,
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: tabIndex,
                  builder: (context, value, child) {
                    return builtTab(
                      iconWidget: SvgPicture.asset(
                        AppAssets.historyIcon,
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                      label: 'history'.tr(),
                      isSelected: value == 1,
                      context: context,
                    );
                  },
                ),
              ],
              labelPadding: EdgeInsetsGeometry.symmetric(
                vertical: context.height * 0.01,
              ),
            ),
          ),

          /// tabs ==========================================================
          Expanded(
            child: TabBarView(
              children: [
                SafeArea(
                  bottom: true,
                  top: false,
                  child: BlocBuilder<WatchListCubit, WatchListState>(
                    builder: (context, state) {
                      if (state is WatchListSuccessState) {
                        return WatchlistMovieGrid(moviesList: state.movies);
                      }

                      if (state is WatchListErrorState) {
                        return Text(
                          state.message,
                          style: AppStyles.robotoBold20White(context),
                          textAlign: TextAlign.center,
                        );
                      }

                      if (state is WatchListEmptyState) {
                        return Center(
                          child: Image.asset(
                            AppAssets.emptyListImage,
                            width: context.width * 0.26,
                          ),
                        );
                      }

                      return MovieGridShimmerWidget();
                    },
                  ),
                ),
                SafeArea(
                  bottom: true,
                  top: false,
                  child: BlocBuilder<HistoryCubit, HistoryState>(
                    builder: (context, state) {
                      if (state is HistorySuccessState) {
                        return HistoryMovieGrid(moviesList: state.movies);
                      }

                      if (state is HistoryErrorState) {
                        return Text(
                          state.message,
                          style: AppStyles.robotoBold20White(context),
                          textAlign: TextAlign.center,
                        );
                      }

                      if (state is HistoryEmptyState) {
                        return Center(
                          child: Image.asset(
                            AppAssets.emptyListImage,
                            width: context.width * 0.26,
                          ),
                        );
                      }

                      return MovieGridShimmerWidget();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget builtTab({
    required Widget iconWidget,
    required String label,
    required bool isSelected,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 24, height: 24, child: iconWidget),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppStyles.robotoRegular14White(context).copyWith(
              color: isSelected ? AppColors.yellowColor : AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
