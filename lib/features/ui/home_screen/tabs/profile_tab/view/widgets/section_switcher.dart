import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../core/utils/app_assets.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';
import '../../cubit/watchlist_view_model.dart';
import '../../watchlist_state.dart';
import 'movie_grid.dart';
import 'movie_grid_shimmer_widget.dart';

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
                      label: 'WatchList',
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
                      label: 'History',
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
                  child: BlocBuilder<WatchListCubit, WatchListState>(
                    builder: (context, state) {
                      if (state is WatchListSuccessState) {
                        return MovieGrid(movies: state.movies);
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: context.height * 0.1),
                              Image.asset(
                                AppAssets.emptyListImage,
                                width: context.width * 0.26,
                              ),
                            ],
                          ),
                        );
                      }

                      return MovieGridShimmerWidget();
                    },
                  ),
                ),
                SafeArea(
                  bottom: true,
                  child: BlocBuilder<WatchListCubit, WatchListState>(
                    builder: (context, state) {
                      if (state is WatchListSuccessState) {
                        return MovieGrid(movies: state.movies);
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: context.height * 0.1),
                              Image.asset(
                                AppAssets.emptyListImage,
                                width: context.width * 0.26,
                              ),
                            ],
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
