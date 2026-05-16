import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/widgets/custom_text_form_field.dart';
import 'package:movies/widgets/main_error_widget.dart';

import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/screen_size.dart';
import '../../../../../../widgets/movie_list_shimmer_widget.dart';
import '../../../../../../widgets/movie_list_widget.dart';
import '../cubit/search_view_model.dart';
import '../search_state.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late ScrollController scrollController;
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(keepScrollOffset: true)
      ..addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SearchCubit>();

    return SafeArea(
      bottom: false,
      child: Column(
        spacing: context.width * 0.04,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(
              top: context.width * 0.04,
              left: context.width * 0.04,
              right: context.width * 0.04,
            ),
            child: CustomTextFormField(
              controller: cubit.searchController,
              onChanged: onSearchChanged,

              prefixIcon: SvgPicture.asset(
                AppAssets.bnbSearchIcon,
                fit: BoxFit.none,
              ),
              hintText: "search".tr(),
              hintStyle: AppStyles.robotoRegular16White(context),
              filled: true,
              fillColor: AppColors.darkGrayColor,
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoadingState) {
                  return MovieListShimmerWidget();
                }

                if (state is SearchEmptyState) {
                  return Center(
                    child: Text(
                      'no_movies_for_this_search_term'.tr(),
                      style: AppStyles.robotoBold20White(context),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (state is SearchSuccessState) {
                  return MovieListWidget(
                    scrollController: scrollController,
                    isPaginationLoading: state.isPaginationLoading,
                    moviesList: state.moviesList,
                  );
                }

                if (state is SearchErrorState) {
                  return MainErrorWidget(
                    errorMessage: state.message,
                    onPressed: () {
                      context.read<SearchCubit>().getSearchMovies();
                    },
                    widgetHeight: context.height,
                  );
                }
                return Center(child: Image.asset(AppAssets.emptyListImage));
              },
            ),
          ),
        ],
      ),
    );
  }

  void onScroll() {
    final cubit = context.read<SearchCubit>();

    if (cubit.isFetching || cubit.hasReachedMax) {
      return;
    }
    final maxScroll = scrollController.position.maxScrollExtent;

    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= maxScroll - 400) {
      cubit.getSearchMovies(isPagination: true);
    }
  }

  void onSearchChanged(String value) {
    var cubit = context.read<SearchCubit>();

    if (value.trim().isEmpty) {
      debounce!.cancel();
      cubit.emitInitialState();
    } else {
      if (debounce?.isActive ?? false) debounce!.cancel();

      debounce = Timer(const Duration(milliseconds: 700), () {
        if (!mounted) return;

        final trimmedValue = value.trim();

        if (trimmedValue.isEmpty) return;
        cubit.searchTerm = value.trim();
        cubit.getSearchMovies();
      });
    }
  }
}
