import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/constants/app_constants.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/screen_size.dart';
import '../../cubit/browse_view_model.dart';

class GenresTabBar extends StatelessWidget {
  const GenresTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BrowseCubit>();

    return DefaultTabController(
      initialIndex: AppConstants.genresList.indexOf(cubit.selectedGenre),
      length: AppConstants.genresList.length,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        labelPadding: EdgeInsetsDirectional.only(start: context.width * 0.04),
        padding: EdgeInsetsDirectional.only(top: context.width * 0.04),
        dividerColor: AppColors.transparentColor,
        indicatorColor: AppColors.transparentColor,
        isScrollable: true,

        onTap: (index) {
          if (cubit.selectedGenre == AppConstants.genresList[index]) {
            return;
          }

          cubit.changeGenre(index);
          cubit.getBrowseMovies();
        },
        tabs: AppConstants.genresList.map((genre) {
          bool isSelected = cubit.selectedGenre == genre;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: BoxBorder.all(
                color: isSelected
                    ? AppColors.transparentColor
                    : AppColors.yellowColor,
                width: 2,
              ),
              color: isSelected
                  ? AppColors.yellowColor
                  : AppColors.transparentColor,
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
            child: Text(
              genre.tr(),
              style: isSelected
                  ? AppStyles.interBold20yellow.copyWith(
                      color: AppColors.blackColor,
                    )
                  : AppStyles.interBold20yellow,
            ),
          );
        }).toList(),
      ),
    );
  }
}
